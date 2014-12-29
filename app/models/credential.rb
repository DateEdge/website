class Credential < ActiveRecord::Base
  belongs_to :provider
  validates :provider_id, :token, presence: true
end
