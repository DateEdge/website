class UsernameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.available_username(value).nil?
      record.errors[attribute] << "#{value} has already been taken"
    end
  end
end

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !EmailAddressValidator.validate_addr(value,true)
      record.errors[attribute] << "is not valid"
    end
  end
end

class BirthdayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank? || value < 100.years.ago.to_date
      record.errors[attribute] << "is required"
    end
  end
end

class User < ActiveRecord::Base
  include PgSearch
  pg_search_scope :text_search, 
    against: {username: "A", city: "B", me_gender: "C"}, 
    using: {tsearch: {dictionary: "english", prefix: true, suffix: true}},
    ignoring: :accents, 
    associated_against: {
      state:   [:name, :abbreviation],
      label:   [:name],
      diet:    [:name],
      country: [:name, :abbreviation]
    }
    
  pg_search_scope :field_search, lambda { |query|
    field   = COLUMN_MAPPING[query.keys.first.to_sym]
    field ||= query.keys.first.to_sym
    if ASSOCIATED_MAPPING.has_key?(field)
      { associated_against: {field => ASSOCIATED_MAPPING[field]}, query: query.values.first.gsub("/", " or ") }
    else
      field = :username if DISALLOWED_COLUMNS.include? field
      { against: field, query: query.values.first }
    end
  }
  
  DISALLOWED_COLUMNS = [
    :id, 
    :me_gender_map, 
    :you_gender_map, 
    :visible, 
    :bio, 
    :canonical_username, 
    :name, 
    :email, 
    :created_at, 
    :updated_at, 
    :agreed_to_terms_at, 
    :birthday, 
    :settings, 
    :auth_token
  ]
  
  COLUMN_MAPPING = {
    gender: :me_gender,
    genders: :me_gender,
    straightedgeness: :label,
    diets: :diet
  }
  
  ASSOCIATED_MAPPING = {
    diet:    :name,
    diet:    :name,
    label:   :name,
    state:   [:name, :abbreviation],
    country: [:name, :abbreviation]
  }
  
  self.per_page = 30
  store_accessor :settings, :admin, :featured, :birthday_public, :real_name_public, :email_public

  scope :with_setting, lambda { |key, value| where("settings -> ? = ?", key, value.to_s) }
  scope :featured, -> { with_setting(:featured, true) }

  belongs_to :country
  belongs_to :diet
  belongs_to :state
  belongs_to :label

  has_many :crushings, foreign_key: "crusher_id", class_name: "Crush", dependent: :destroy
  has_many :secret_crushes, -> { where crushes: {secret: true}}, through: :crushings, source: :crushee

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, foreign_key: "bookmarkee_id", through: :bookmarks, source: :bookmarkee

  has_many :crushes, -> { includes(:crushes).order("crushes.created_at desc")}, through: :crushings, source: :crushee

  has_many :crusheeings, -> { where secret: false }, foreign_key: "crushee_id", class_name: "Crush"
  has_many :crushers, -> { includes(:crushes).order("crushes.created_at desc") }, through: :crusheeings, source: :crusher

  has_many :blocks, foreign_key: :blocker_id
  has_many :blockings, foreign_key: :blocked_id, class_name: "Block"

  has_many :blocked_users, through: :blocks

  has_many :outbound_conversations, class_name: "Conversation", foreign_key: :user_id, dependent: :destroy
  has_many :inbound_conversations,  class_name: "Conversation", foreign_key: :recipient_id, dependent: :destroy
  has_many :outbound_messages, class_name: "Message", foreign_key: :sender_id
  has_many :inbound_messages, class_name: "Message", foreign_key: :recipient_id

  has_many :providers, dependent: :destroy
  has_many :photos, -> { order "created_at desc" }, dependent: :destroy
  has_many :your_labels
  has_many :desired_labels, -> { uniq }, through: :your_labels, source: :label, as: :label, source_type: "Label"
  has_many :desired_diets,  -> { uniq }, through: :your_labels, source: :label, as: :label, source_type: "Diet"

  accepts_nested_attributes_for :your_labels, allow_destroy: true, reject_if: proc { |obj| obj['label_id'] == "0" }

  scope :visible,       -> { where(visible: true) }
  scope :invisible,     -> { where(visible: false) }
  scope :with_provider, lambda { |name, uid| joins(:providers).where(providers: {name: name, uid: uid}) }
  scope :with_username, lambda { |username| where(canonical_username: (username || "").downcase) }
  scope :adults,        -> { where(['birthday >= ?', 18.years.ago]) }
  scope :kids,          -> { where(['birthday <  ?', 18.years.ago]) }
  scope :secret,        -> { joins(:crushes).where('crushes.secret = "true"') }

  validates :username, :canonical_username, presence: { on: :update }, length: { minimum: 1, maximum: 100 }, format: {with: /\A[\.a-zA-Z0-9_-]+\z/, message: "can only contain standard characters"}
  validates :name, :auth_token,     presence: true
  validates :email,    presence: { on: :update }, email: { on: :update }
  validates :birthday, birthday: { on: :update }
  validates :agreed_to_terms_at, presence: { on: :update, message: "must be agreed upon"}

  before_save :groom_string_fields
  
  before_validation :create_canonical_username
  before_validation :generate_auth_token, on: :create

  def to_param
    username
  end
  class << self
    
    def search(search)
      age = search.delete(:age) if search.is_a? Hash
      query = if search.is_a?(Hash) && !search.blank?
        field_search(search) 
      elsif !search.blank?
        text_search(search)       
      else
        all
      end
      query = query.age(age) if age.present?
      query
    end
    
    def age(args)
      beginning, end_year = args.respond_to?(:each) ? [args.last.to_i, args.first.to_i] : [args.to_i, args.to_i]
      where(birthday: ((beginning.years.ago - 1.year)..end_year.years.ago))
    end
    
    def create_with_omniauth(auth)
      user = send("create_for_#{auth["provider"]}", auth)
      user
    end

    def create_for_twitter(auth)
      location = auth["info"]["location"]

      provider = Provider.new(name: auth["provider"], uid: auth['uid'])

      u = create! do |user|
        user.providers << provider
        user.name             = auth["info"]["name"]

        unless location.blank?
          user.city             = location.split(",").first.strip
          user.state            = State.where(abbreviation: location.split(",").last.strip).first
        end

        user.username         = available_username(auth["info"]["nickname"])
        user.bio              = auth["info"]["description"]
        user.country          = Country.where(abbreviation: "US").first

        # v2
        # user.url       = auth["info"]["urls"]["Website"]
        # user.url       = auth["info"]["urls"]["Twitter"]
      end
      unless auth["info"]["image"].blank?
        begin
          u.photos.create(remote_image_url: auth["info"]["image"].sub(/_normal\./, "."), avatar: true)
        rescue OpenURI::HTTPError
        end
      end

      u
    end

    def create_for_facebook(auth)
      location = auth["info"]["location"]

      provider = Provider.new(name: auth["provider"], uid: auth['uid'])

      u = create! do |user|
        user.providers << provider
        user.name       = auth["info"]["name"]

        unless location.blank?
          user.city       = location.split(",").first.strip
          user.state      = State.where(name: location.split(",").last.strip).first
        end

        user.username   = available_username(auth["info"]["nickname"])
        user.email      = auth["info"]["email"]
        user.bio        = auth["info"]["description"]
        user.country    = Country.where(abbreviation: "US").first
        user.me_gender  = auth["extra"]["raw_info"]["gender"]
        # user.url       = auth["user_info"]["urls"]["Website"]
        # user.url       = auth["user_info"]["urls"]["Facebook"]
      end
      if auth["info"].try(:[], "image")
        u.photos.create(remote_image_url: auth["info"]["image"].sub(/type=square/, "type=large"), avatar: true)
      end
      u
    end

    def available_username(username)
      username.blank? || User.with_username(username).any? ? generate_username : username
    end

    def in_my_age_group(user)
      if user.nil? || user.birthday.nil?
        User.all
      elsif user.birthday? && user.birthday < 18.years.ago.to_date
        User.kids
      else
        User.adults
      end
    end

  end

  def viewable_users
    User.
      visible.
      where.not(id: id).
      in_my_age_group(self).
      where.not(id: blocks.pluck(:blocked_id)).
      where.not(id: blockings.pluck(:blocker_id))
  end

  def block_with_user?(user)
    block_from_user?(user) || block_to_user?(user)
  end

  def block_from_user?(user)
    user.blocks.where(blocked_id: self.id).any?
  end

  def block_to_user?(user)
    blocks.where(blocked_id: user.id).any?
  end

  def available_username(new_name)
    (User.with_username(new_name) - [self]).any? ? nil : new_name
  end

  def conversations
    Conversation.with_user(self)
  end

  def avatar(size=:avatar)
    size = :avatar if size.nil?

    photo = photos.where(avatar: true).first
    photo ? photo.image_url(size) : placeholder_avatar_url
  end

  def you_gender
    self.you_gender? ? super : "person"
  end

  def me_gender
    self.me_gender? ? super : "person"
  end

  def merge!(merging_user)
    %w(name email birthday city state zipcode country bio).each do |property|
      self.send("#{property}=", merging_user.send(property)) if self.send(property).blank?
    end

    merging_user.your_labels.each do |your_label|
      if self.your_labels.map{ |l| l.label_id }.include?(your_label.label_id)
        your_label.destroy
      else
        your_label.update_attributes!(user_id: self.id)
      end
    end

    save!(validate: false)
  end

  def visiblize!
    update_attributes(visible: (email? && username?))
  end

  def age
    unless birthday.nil?
      now = Time.now.utc.to_date
      now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
    end
  end

  def twitter?
    check_provider "twitter"
  end

  def facebook?
    check_provider "facebook"
  end

  def age_inappropiate?(user)
    !age_appropiate?(user)
  end

  def age_appropiate?(user)
    if user && user.birthday?
      user.age_group == self.age_group
    else
      true
    end
  end

  def secret_crushing_on?(user)
    secret_crushes.include? user
  end

  def crushing_on?(user)
    crush_with(user).present?
  end

  def bookmarking?(user)
    bookmark_with(user).present?
  end

  def crush_with(user)
    crushings.find_by(crushee_id: user.id)
  end

  def bookmark_with(user)
    bookmarks.find_by(bookmarkee_id: user.id)
  end

  def age_group
    age >= 18 ? :adult : :kid
  end

  def self.generate_username
    "username-#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end

  def self.attribute(name)
      superclass.send :define_method, name do
        self
      end
    end

  %w(admin featured birthday_public real_name_public email_public).each do |method_name|
    define_method("#{method_name}?") do
      %w(true false 0 1).include?(send(method_name)) ? %w(true 1).include?(send(method_name)) : send(method_name)
    end
  end

  # TODO put this into settings
  def twitter_username;     false; end
  def facebook_username;    false; end
  def vine_username;        false; end
  def kik_username;         false; end
  def thisismyjam_username; false; end
  def instagram_username;   false; end

  private

  def placeholder_avatar_url
    "placeholder.png"
  end

  def check_provider(name)
    providers.any? {|p| p.name == name }
  end

  def groom_string_fields
    %w(you_gender me_gender).each do |field|
      if field
        send(field).downcase!
        send(field).strip!
      end
    end
  end

  def create_canonical_username
    self.canonical_username = username.downcase if username
  end

  def generate_auth_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token])
  end

end
