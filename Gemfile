source "http://rubygems.org"

group :development do
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "foreman"
end

group :test, :development do
  gem "rspec-rails", "~> 2.4"
end

group :test do
  gem "autotest"
  gem "rspec"
end

group :production do
  gem "pg"
  gem "thin"
end

gem "rails", "3.0.9"
gem "omniauth", "0.2.6"