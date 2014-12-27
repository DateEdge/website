if Rails.env.production?
  puts ENV.inspect
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque.redis = redis
else
  Resque.redis = Redis.new
end
