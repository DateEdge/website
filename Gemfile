source "https://rubygems.org"

ruby "2.1.2"

gem "coffee-rails",            "~> 4.0.0"
gem "email_address_validator", "0.0.3",   git: "git://github.com/bookis/email_address_validator"
gem "indefinite_article"
gem "jquery-rails"
gem "json"
gem "pg"
gem "rails",                   "~> 4.1.4"
gem "redcarpet" # Markdown parser
gem "rollbar"   # Exception notifier
gem "sass-rails"
gem "uglifier",                ">= 1.3.0"
gem "will_paginate"
gem "will_paginate-bootstrap"

# caching
gem "memcachier"
gem "dalli"
gem "kgio"

# background
gem 'resque', "~> 1.22.0", require: "resque/server"

# search
gem "pg_search"

# image uploads
gem "rmagick",            "~> 2.13.2", require: false
gem "fog",                "~> 1.22.1"
gem "carrierwave"

# auth
gem "omniauth-twitter",   "~> 1.0.1"
gem "omniauth-facebook",  "~> 1.6.0"


group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "foreman"
  gem "guard-rspec"
  gem "gx"

  # For Rails 4.1
  gem "spring"
end

group :test, :development do
  gem "capybara"
  gem "factory_girl_rails"
  gem "poltergeist"
  gem "rspec-rails", "~> 2.99.0"
  gem "terminal-notifier-guard"
end

group :test do
  gem "database_cleaner"
  gem "rspec", "~> 2.99.0"
end

group :production, :staging do
  gem "newrelic_rpm"
  gem "puma"
  gem "rails_12factor"
end
