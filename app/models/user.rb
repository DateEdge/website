class User < ActiveRecord::Base

  belongs_to :country
  belongs_to :diet
  belongs_to :state
  has_many :photos

  validates :username, :presence => { :on => :update }
  validates :name, :presence => true
  validates :email, :presence => { :on => :update }
  # validates :email, :format => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  before_save :downcase_genders

  class << self
    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid      = auth["uid"]
        user.name     = auth["user_info"]["name"]
        user.email    = auth["user_info"]["email"]
      end
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
    you_gender.downcase!
    me_gender.downcase!
  end
end
