class Provider < ActiveRecord::Base
  belongs_to :user
  validates :name, :uniqueness => { :scope => :uid }
end
