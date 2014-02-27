source "https://rubygems.org"

ruby "1.9.3"

gem "coffee-rails",            "~> 4.0.0"
gem "email_address_validator", "0.0.3",   git: "git://github.com/bookis/email_address_validator"
gem "indefinite_article"
gem "jquery-rails"
gem "json"
gem "pg"
gem "rails",                   "~> 4.0.2"
gem "redcarpet" # Markdown parser
gem "rollbar"   # Exception notifier
gem "sass-rails"
gem "uglifier",                ">= 1.3.0"
gem "will_paginate", "~> 3.0"
gem "will_paginate-bootstrap"

# caching
gem "memcachier"
gem "dalli"
gem "kgio"

# search
gem "pg_search"

# image uploads
gem "rmagick",            "~> 2.13.2"
gem "fog",                "~> 1.12.1"
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
end

group :test, :development do
  gem "capybara"
  gem "factory_girl_rails"
  gem "poltergeist"
  gem "rspec-rails"
  gem "terminal-notifier-guard"
end

group :test do
  gem "database_cleaner"
  gem "rspec"
end

group :production, :staging do
  gem "newrelic_rpm"
  gem "puma"
  gem "rails_12factor"
end
