Rails.application.config.after_initialize do
  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    puts "*" * 80
    puts Rails.env
    puts Rails.application.config.database_configuration.inspect
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = 10
    config['pool']              = 5
    ActiveRecord::Base.establish_connection(config)
  end
end