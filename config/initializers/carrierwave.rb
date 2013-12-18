if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage =  :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV["DXE_AWS_ACCESS_KEY"],
      aws_secret_access_key: ENV["DXE_AWS_SECRET_KEY"]
    }
    config.fog_directory  = ENV["FOG_DIRECTORY"]
    config.asset_host     = ENV["FOG_ASSET_HOST"]
  end
end

