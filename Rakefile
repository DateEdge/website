# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'fileutils'

Dxe::Application.load_tasks

task recreate_photos: :environment do
  puts "Recreating Photos"
  Photo.all.each do |photo| 
    puts "Recreating photo #{photo.id}"
    begin
      photo.image.recreate_versions! 
    rescue NoMethodError => e
      puts "IMAGE DOES NOT EXIST"
    end
  end
end

namespace :deploy do
  task parameterize_invalid_usernames: :environment do
    puts "Updating invalid usernames"
    users = User.where(visible: true)
    users.each {|user| 
      if !user.valid?
        success = user.update(username: user.username.parameterize)
        if !success
          puts "#{user.username} failed to update"
        end
      end
    }
  end
  
end

namespace :db do
  
  task import: :environment do
    puts "Backing Up Production Database..."
    `heroku pgbackups:capture --expire`
    puts "Downloading Database Dump..."
    `curl -o db/dxe-production.dump \`heroku pgbackups:url\``
    puts "Importing Production Data..."
    `pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d dxe_development db/dxe-production.dump`
    puts "Deleting Dump File..."
    FileUtils.rm("db/dxe-production.dump")
    puts "Finished Import"
  end
end
