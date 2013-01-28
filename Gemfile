source "http://rubygems.org"

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "foreman"
  # gem "rb-fsevent"
  gem "growl"
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
  gem "puma"
end

gem "rails",             "~> 3.0.9"
gem "rmagick",           "~> 2.13.1"
gem "fog",               "~> 1.9.0"
gem "carrierwave"

gem "omniauth-twitter",  "~> 0.0.14"
gem "omniauth-facebook", "~> 1.4.1"
