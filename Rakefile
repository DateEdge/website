# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

Dxe::Application.load_tasks

task recreate_photos: :environment do
  puts "Recreating Photos"
  Photo.all.each do |photo| 
    puts "Recreating photo #{photo.id}"
    photo.image.recreate_versions! 
  end
end
