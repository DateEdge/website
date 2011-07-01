class User < ActiveRecord::Base

  belongs_to :country
  belongs_to :diet
  belongs_to :state
  belongs_to :label

  has_many :photos

  has_many :your_labels
  has_many :desired_labels, :through => :your_labels, :source => :label, :uniq => true
  accepts_nested_attributes_for :your_labels, :allow_destroy => true

  validates :username, :presence => { :on => :update }
  validates :name, :presence => true
  validates :email, :presence => { :on => :update }
  # validates :email, :format => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  before_save :downcase_genders

  class << self
    def create_with_omniauth(auth)
      send("create_for_#{auth["provider"]}", auth)
    end

    def create_for_twitter(auth)
      location = auth["extra"]["user_hash"]["location"]

      create! do |user|
        user.provider  = auth["provider"]
        user.name      = auth["user_info"]["name"]
        user.city      = location.split(",").first.strip
        user.state     = State.where(:abbreviation => location.split(",").last.strip).first
        user.username  = available_username(auth["extra"]["user_hash"]["screen_name"])
        user.uid       = auth["uid"]
        user.name      = auth["user_info"]["name"]
        user.bio       = auth["user_info"]["description"]
        user.country   = Country.where(:abbreviation => "US").first
        # user.url       = auth["user_info"]["urls"]["Website"]
        # user.url       = auth["user_info"]["urls"]["Twitter"]
        # user.image     = auth["user_info"]["image"].sub(/_normal\./, ".")
      end
    end

    def create_for_facebook(auth)
      location = auth["extra"]["user_hash"]["location"]["name"]

      create! do |user|
        user.provider  = auth["provider"]
        user.name      = auth["user_info"]["name"]
        user.city      = location.split(",").first.strip
        user.state     = State.where(:name => location.split(",").last.strip).first
        user.username  = available_username(auth["extra"]["user_hash"]["screen_name"])
        user.uid       = auth["uid"]
        user.name      = auth["user_info"]["name"]
        user.email     = auth["user_info"]["email"]
        user.bio       = auth["extra"]["user_hash"]["bio"]
        user.country   = Country.where(:abbreviation => "US").first
        user.me_gender = auth["extra"]["user_hash"]["gender"]
        # user.url       = auth["user_info"]["urls"]["Website"]
        # user.url       = auth["user_info"]["urls"]["Facebook"]
        # user.image     = auth["user_info"]["image"].sub(/type=square/, "type=large")
      end
    end

    def available_username(username)
      User.where(:username => username).first ? nil : username
    end
  end

  def age
    unless birthday.nil?
      now = Time.now.utc.to_date
      now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  end

  private

  def downcase_genders
    you_gender.downcase! if you_gender?
    me_gender.downcase! if me_gender?
  end
end
