source "http://rubygems.org"

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "foreman"
  gem 'rb-fsevent'
  gem 'growl'
  gem "guard-rspec"
end

group :test, :development do
  gem "rspec-rails", "~> 2.4"
end

group :test do
  gem "rspec"
  gem "database_cleaner"
end

group :production do
  gem "pg"
  gem "thin"
end

gem "rails",     "3.0.9"
gem "omniauth",  "0.2.6"
gem "rmagick"
gem 'fog'
gem "carrierwave"
