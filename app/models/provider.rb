class Provider < ActiveRecord::Base
  belongs_to :user
  validates  :uid, uniqueness: { scope: :name }
  
  def self.from_auth(auth_hash, params={})
    provider = find_by(name: auth_hash.provider, uid: auth_hash.uid)
    if provider
      provider.update(params.merge(
        last_login_at: Time.now, 
        handle: auth_hash.info.nickname || auth_hash.info.name)
      ) 
    end
    provider
  end
end
