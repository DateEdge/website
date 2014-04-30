if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  if ENV["DXE_AWS_ACCESS_KEY"]
    CarrierWave.configure do |config|
      config.storage =  :fog
      config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV["DXE_AWS_ACCESS_KEY"],
        aws_secret_access_key: ENV["DXE_AWS_SECRET_KEY"],
        region:                ENV["DXE_AWS_REGION"]
      }
      config.fog_directory  = ENV["FOG_DIRECTORY"]
      config.asset_host     = "https://#{ENV["FOG_DIRECTORY"]}.s3.amazonaws.com"
    end
  end
end

