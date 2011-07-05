class Provider < ActiveRecord::Base
  belongs_to :user
  validates :uid, :uniqueness => { :scope => :name }
end
