class User < ActiveRecord::Base
  
  belongs_to :country
  has_many :photos

  validates :username, :name, :email, :presence => true
  validates :email, :format => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  class << self
    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid      = auth["uid"]
        user.name     = auth["user_info"]["name"]
      end
    end
  end

end
