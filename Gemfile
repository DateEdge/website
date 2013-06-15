source "http://rubygems.org"

gem "rails",              "~> 3.2.13"
gem "json"
gem "jquery-rails"

# image uploads
gem "rmagick",            "~> 2.13.2"
gem "fog",                "~> 1.12.1"
gem "carrierwave"

# auth
gem "omniauth-twitter",   "~> 0.0.16"
gem "omniauth-facebook",  "~> 1.4.1"

group :development do
  gem "gx"
  gem "sqlite3"
  gem "foreman"
  gem "guard-rspec"
end

group :test, :development do
  gem "rspec-rails"
end

group :test do
  gem "rspec"
  gem "database_cleaner"
end

group :production do
  gem "pg"
  gem "puma"
end

group :assets do
  gem "sass-rails"
  gem "uglifier"
  gem "modernizr-rails"
end
