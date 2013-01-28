source "http://rubygems.org"

group :development do
  gem "sqlite3-ruby",     "~> 1.3.3", :require => "sqlite3"
  gem "foreman",          "~> 0.61.0"
  gem "growl",            "~> 1.0.3"
  gem "guard-rspec",      "~> 2.4.0"
  # gem "rb-fsevent"
end

group :test, :development do
  gem "rspec-rails",      "~> 2.12.2"
end

group :test do
  gem "rspec",            "~> 2.12.0"
  gem "database_cleaner", "~> 0.9.1"
end

group :production do
  gem "pg",               "~> 0.14.1"
  gem "puma",             "~> 1.6.3"
  
  # for heroku
  gem "rails_log_stdout", "~> 0.1.1"
end

gem "rails",              "~> 3.2.11"
gem "rmagick",            "~> 2.13.1"
gem "fog",                "~> 1.9.0"
gem "carrierwave"

gem "omniauth-twitter",   "~> 0.0.14"
gem "omniauth-facebook",  "~> 1.4.1"
