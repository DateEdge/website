class BlacklistValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value && USERNAME_BLACKLIST.include?(value.downcase)
      record.errors[attribute] << "#{value} is not an allowed username."
    end
  end
end

class User < ActiveRecord::Base
  belongs_to :country
  belongs_to :diet
  belongs_to :state
  belongs_to :label

  has_many :crushings, :foreign_key => "crusher_id", :class_name => "Crush"
  has_many :crushes, :through => :crushings, :source => :crushee

  has_many :crusheeings, :foreign_key => "crushee_id", :class_name => "Crush", :conditions => {:secret => false}
  has_many :crushers, :through => :crusheeings, :source => :crusher

  has_many :outbound_conversations, :class_name => "Conversation", :foreign_key => :user_id
  has_many :inbound_conversations,  :class_name => "Conversation", :foreign_key => :recipient_id

  has_many :providers, :dependent => :destroy
  has_many :photos
  has_many :your_labels
  has_many :desired_labels, :through => :your_labels, :source => :label, :uniq => true

  accepts_nested_attributes_for :your_labels, :allow_destroy => true

  scope :public,  where(:public => true)
  scope :private, where(:public => false)
  scope :with_provider, lambda { |name, uid| joins(:providers).where(:providers => {:name => name, :uid => uid}) }
  scope :adults, lambda {where(['birthday >= ?', 18.years.ago]) }
  scope :kids,   lambda {where(['birthday <  ?', 18.years.ago]) }

  validates :username, :presence => { :on => :update }, :blacklist => true
  validates :name, :presence => true
  validates :email, :presence => { :on => :update }
  # validates :email, :format => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  before_save :downcase_genders

  class << self
    def create_with_omniauth(auth)
      user = send("create_for_#{auth["provider"]}", auth)
      user.publicize!
      user
    end

    def create_for_twitter(auth)
      location = auth["extra"]["user_hash"]["location"]
      provider = Provider.create!(:name => auth["provider"], :uid => auth['uid'])

      u = create! do |user|
        user.providers << provider
        user.name             = auth["user_info"]["name"]
        user.city             = location.split(",").first.strip
        user.state            = State.where(:abbreviation => location.split(",").last.strip).first
        user.username         = available_username(auth["extra"]["user_hash"]["screen_name"])
        user.name             = auth["user_info"]["name"]
        user.bio              = auth["user_info"]["description"]
        user.country          = Country.where(:abbreviation => "US").first

        # v2
        # user.url       = auth["user_info"]["urls"]["Website"]
        # user.url       = auth["user_info"]["urls"]["Twitter"]
      end

      unless auth["user_info"]["image"].blank?
        u.photos.create!(:remote_image_url => auth["user_info"]["image"].sub(/_normal\./, "."), :avatar => true)
      end
      u
    end

    def create_for_facebook(auth)
      location = auth["extra"]["user_hash"]["location"]["name"]
      provider = Provider.create!(:name => auth["provider"], :uid => auth['uid'])

      u = create! do |user|
        user.providers << provider
        user.name       = auth["user_info"]["name"]
        unless location.blank?
          user.city       = location.split(",").first.strip
          user.state      = State.where(:name => location.split(",").last.strip).first
        end
        user.username   = available_username(auth["extra"]["user_hash"]["username"])
        user.name       = auth["user_info"]["name"]
        user.email      = auth["user_info"]["email"]
        user.bio        = auth["extra"]["user_hash"]["bio"]
        user.country    = Country.where(:abbreviation => "US").first
        user.me_gender  = auth["extra"]["user_hash"]["gender"]
        # user.url       = auth["user_info"]["urls"]["Website"]
        # user.url       = auth["user_info"]["urls"]["Facebook"]
        # user.image     = auth["user_info"]["image"].sub(/type=square/, "type=large")
      end

      unless auth["user_info"]["image"].blank?
        u.photos.create!(:remote_image_url => auth["user_info"]["image"].sub(/type=square/, "type=large"), :avatar => true)
      end
      u
    end

    def available_username(username)
      User.where(:username => username).first ? nil : username
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

  def conversations
    (inbound_conversations + outbound_conversations).sort_by { |c| c.updated_at }.uniq
  end

  def avatar
    photo = photos.where(:avatar => true).first
    photo ? photo.image_url(:avatar) : PLACEHOLDER_AVATAR_URL
  end

  def merge!(merging_user)
    %w(name email birthday city state zipcode country bio).each do |property|
      self.send("#{property}=", merging_user.send(property)) if self.send(property).blank?
    end

    merging_user.your_labels.each do |your_label|
      if self.your_labels.map{ |l| l.label_id }.include?(your_label.label_id)
        your_label.destroy
      else
        your_label.update_attributes!(:user_id => self.id)
      end
    end

    save!
  end

  def publicize!
    update_attributes(:public => (email? && username?))
  end

  def age
    unless birthday.nil?
      now = Time.now.utc.to_date
      now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  end

  def twitter?
    check_provider "twitter"
  end

  def facebook?
    check_provider "facebook"
  end

  def age_appropiate?(user)
    if user && user.birthday?
      user.age_group == self.age_group
    else
      true
    end
  end

  def crushing_on?(user)
    crushes.include? user
  end

  private

  def age_group
    birthday > 18.years.ago.to_date ? :adult : :kid
  end

  def check_provider(name)
    providers.any? {|p| p.name == name }
  end

  def downcase_genders
    you_gender.downcase! if you_gender?
    me_gender.downcase!  if me_gender?
  end
end
