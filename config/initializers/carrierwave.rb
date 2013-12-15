CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAJJU6W55ZCDRCHEDQ',
    aws_secret_access_key: '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',
    region:                'us-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = "dxe-#{Rails.env}"
  # config.fog_host       = 'https://assets.example.com'
  # config.fog_public     = false
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end