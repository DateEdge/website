puts "Adding labels"
puts
["straightedge","drug free","straightedge curious","some drug using"].each do |label|
  Label.create!(:name => label)
end

puts "Adding diets"
puts
%w(raw vegan vegetarian pescatarian kosher freegan omnivore).each do |diet|
  Diet.create!(:name => diet)
end

__END__


if Rails.env.development?
  puts "Adding fake users"
  puts
  {
    :veganbookis          => "http://farm4.static.flickr.com/3287/3126230096_0c7d7e9f6f_z.jpg",
    :shaners              => "http://farm6.static.flickr.com/5127/5728349801_1b7db3bce4_b.jpg",
    :boo                  => "http://farm1.static.flickr.com/178/434774409_68abf27036_z.jpg?zz=1",
    :radley               => "http://farm3.static.flickr.com/2440/3654633348_ee0b9ffe7c_z.jpg",
    :urchin               => "http://farm2.static.flickr.com/1194/832635950_601afd8a3e_b.jpg",
    :civ                  => "http://farm5.static.flickr.com/4056/4677750358_08f5df69e8_b.jpg",
    :siberianhuskie       => "http://farm1.static.flickr.com/74/163514301_1c9823d5cc_z.jpg?zz=1",
    :sxedude              => "http://farm3.static.flickr.com/2087/1567051898_bdfa75cd64_z.jpg?zz=1",
    :earthcrisis97        => "http://farm6.static.flickr.com/5146/5773103819_97ceacd34f_b.jpg",
    :youthcrew            => "http://img.photobucket.com/albums/v351/Marko138/livejournal/IMG_5078.jpg",
    :xtofux               => "http://farm3.static.flickr.com/2016/5704504989_6b91552765_b.jpg",
    :ilovecarrots         => "http://cdn.buzznet.com/media/jjr/headlines/2009/02/miley-cyrus-carrot-top.jpg",
    :marryacarrot         => "http://www.motleycrow.com/ImageHost/carrot_top1.jpg",
    :savesthedayisthebest => "http://electronicshrug.net/wp-content/uploads/2010/06/saves-the-day2.jpg",
    :slingshot            => "http://farm1.static.flickr.com/77/163422937_3a1917def0_b.jpg",
    :x                    => "http://farm4.static.flickr.com/3409/3472335277_108b35ab8f_b.jpg",
    :xvx                  => "http://25.media.tumblr.com/A6DXfwmvQisoe82obmcZweqBo1_400.jpg",
    :vegan                => "http://i196.photobucket.com/albums/aa236/xvladyx/DSC08164.jpg",
    :xveganx              => "http://i196.photobucket.com/albums/aa236/xvladyx/DSC06853.jpg",
    :razorblades          => "http://farm1.static.flickr.com/220/468045907_e6097423da_b.jpg",
    :doublerainbow        => "http://www.doobybrain.com/wp-content/uploads/2010/07/double-rainbow.jpg",
    :kittens              => "http://cdn.uproxx.com/wp-content/uploads/2010/07/Kitten2.jpg",
    :ponies               => "http://h8.abload.de/img/irina_djangoponyo5dl.jpg",
    :lollipops            => "http://ny-image2.etsy.com/il_fullxfull.12765590.jpg",
    :foo                  => "http://www.lasnark.com/wp-content/uploads/2010/12/foo-fighters-secret-show.jpg",
    :bar                  => "http://www.washingtonian.com/block_dbimages/11608/bar.pilar.bellyup.jpg",
    :baz                  => "http://upload.wikimedia.org/wikipedia/it/thumb/4/40/Baz.jpg/300px-Baz.jpg",
    :snap                 => "http://www.prochoiceamerica.org/assets/images/snap-crackle-pop.jpg",
    :crackle              => "http://bradley.chattablogs.com/elves.jpg",
    :xpopx                => "http://www.chicagonow.com/stump-the-tromp/files/2011/06/snap-crackle-pop.jpg",
  }.each do |username, url|
    puts "user:  #{username.to_s}"

    user = User.new(
      :name     => username,
      :birthday => (rand(20) + 14).years.ago.to_date,
      :visible  => true
    )
  
    user.username = username.to_s
    user.email    = "#{username}@dateedge.com"
    user.save!

    puts "       avatar"
    Photo.create!(:user_id => user.id, :remote_image_url => url, :avatar => true)
    puts "       duplicate photo"
    Photo.create!(:user_id => user.id, :remote_image_url => url)
  end
end
