source "http://rubygems.org"

gem "rails",              "~> 3.2.13"
gem "json"
gem "jquery-rails"

group :development do
  gem "gx",               "~> 1.3.3"
  gem "sqlite3",          "~> 1.3.7"
  gem "foreman",          "~> 0.63.0"
  gem "growl",            "~> 1.0.3"
  gem "guard-rspec",      "~> 3.0.2"
end

group :test, :development do
  gem "rspec-rails",      "~> 2.13.2"
end

group :test do
  gem "rspec",            "~> 2.13.0"
  gem "database_cleaner", "~> 1.0.1"
end

group :production do
  gem "pg",               "~> 0.15.1"
  gem "puma",             "~> 2.0.1"
end

group :assets do
  gem "sass-rails",   "~> 3.2.3"
  # gem "coffee-rails", "~> 3.2.1"
  gem "uglifier",     ">= 1.0.3"
end

# image uploads
gem "rmagick",            "~> 2.13.2"
gem "fog",                "~> 1.12.1"
gem "carrierwave"

# auth
gem "omniauth-twitter",   "~> 0.0.16"
gem "omniauth-facebook",  "~> 1.4.1"
