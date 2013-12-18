Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,  ENV["DXE_TWITTER_CONSUMER_KEY"],  ENV["DXE_TWITTER_CONSUMER_SECRET"]
  provider :facebook, ENV["DXE_FACEBOOK_CONSUMER_KEY"], ENV["DXE_FACEBOOK_CONSUMER_SECRET"]
end
