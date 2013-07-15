source "http://rubygems.org"

ruby "1.9.3"#, :engine => "rbx", :engine_version => "2.0.0.rc1"


gem "rails",              "~> 4.0.0"
gem "pg"
gem "json"
gem "jquery-rails"
gem "rollbar" # Exception notifier
# image uploads
gem "rmagick",            "~> 2.13.2"
gem "fog",                "~> 1.12.1"
gem "carrierwave"

# auth
gem "omniauth-twitter",   "~> 0.0.16"
gem "omniauth-facebook",  "~> 1.4.1"

group :development do
  gem "gx"
  gem "foreman"
  gem "guard-rspec"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test, :development do
  gem "rspec-rails"
end

group :test do
  gem "rspec"
  gem "database_cleaner"
end

group :production do
  gem "puma"
  gem 'rails_12factor'
end

group :assets do
  gem "sass-rails"
  gem "uglifier"
  gem "modernizr-rails"
end
