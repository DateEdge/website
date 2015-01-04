# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'fileutils'

Dxe::Application.load_tasks

task recreate_photos: :environment do
  puts "Recreating Photos"
  Photo.all.each do |photo|
    puts "Queeing photo #{photo.id}"
    begin
      Resque.enqueue(ImageProcessor, photo.id)
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

  task set_default_mailing_options: :environment do
    User.find_in_batches(batch_size: 50) do |group|
      puts "updating #{group.first.id}..."
      group.each {|u| u.update(email_crushes: "1", email_messages: "1")}
    end
  end

end

namespace :geocode do
  task all: :environment do
    users = User.all
    users.each do |user|
      Resque.enqueue(GeocodeLookup, user.id)
    end
  end
end
namespace :db do

  task :import do
    puts "Heroku Toolbelt packages its own Ruby at version 1.9.3."
    puts "Date Edge specifies `ruby '2.1.2'` in the Gemfile."
    puts "Calling the `heroku` from within the Date Edge Ruby space"
    puts "causes a conflict and therefore won't run."
    puts "To get around this (for now), you have to manually run this."
    puts "Copy and paste this long command into your prompt:"

    puts "
  echo 'Backing Up Production Database...' &&
  heroku pgbackups:capture --expire -a dateedge &&
  echo 'Downloading Database Dump...' &&
  curl -o db/dxe-production.dump `heroku pgbackups:url -a dateedge` &&
  echo 'Importing Production Data...' &&
  pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d dxe_development db/dxe-production.dump &&
  echo 'Deleting Dump File...' &&
  rm 'db/dxe-production.dump' &&
  echo 'Finished Import!'"

    # TODO use this when Heroku Toolbelt plays nice with Ruby 2.1.x
    # puts "Backing Up Production Database..."
    # sh "heroku pgbackups:capture --expire -a dateedge"
    # puts "Downloading Database Dump..."
    # sh "curl -o db/dxe-production.dump `heroku pgbackups:url -a dateedge`"
    # puts "Importing Production Data..."
    # sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d dxe_development db/dxe-production.dump"
    # puts "Deleting Dump File..."
    # FileUtils.rm("db/dxe-production.dump")
    # puts "Finished Import"
  end
end
