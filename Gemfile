source "https://rubygems.org"

ruby "1.9.3"

gem "rails",              "~> 4.0.2"
gem "pg"
gem "json"
gem "jquery-rails"
gem "email_address_validator", "0.0.3", git: "git://github.com/bookis/email_address_validator"
gem "rollbar" # Exception notifier
gem "sass-rails"
gem "uglifier"
gem "indefinite_article"
gem "redcarpet" # Markdown parser
gem "will_paginate", "~> 3.0"

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
  gem "factory_girl_rails"
end

group :test do
  gem "rspec"
  gem "database_cleaner"
end

group :production do
  gem "puma"
  gem "rails_12factor"
end
