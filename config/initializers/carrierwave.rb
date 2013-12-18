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
      aws_secret_access_key: ENV["DXE_AWS_SECRET_KEY"],
      endpoint:              "https://assets.dateedge.com:8080"
    }
    unless Rails.env.production?
      config.fog_directory  = "assets.dateedge.com"
      config.asset_host     = 'https://assets.dateedge.com'
    else
      config.fog_directory  = "dxe-#{Rails.env}"
    end
    # config.fog_public     = false
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
end

