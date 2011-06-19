class User < ActiveRecord::Base
  
  belongs_to :country
  has_many :photos

  validates :username, :presence => { :on => :update }
  validates :name, :email, :presence => true
  validates :email, :format => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

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
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
