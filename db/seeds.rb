puts
puts "Adding labels"
["straightedge","drug free","straightedge curious","some drug using"].each do |label|
  Label.create!(:name => label)
  puts "label:  #{label}"
end

puts
puts "Adding diets"
%w(raw vegan vegetarian pescatarian kosher freegan omnivore).each do |diet|
  Diet.create!(:name => diet)
  puts "diet:  #{diet}"
end

# __END__


if Rails.env.development?
  puts "Adding fake users"
  puts
  {
    :baz                  => "http://upload.wikimedia.org/wikipedia/commons/5/5b/Baz_(Marco_Bazzoni).jpg",
    :boo                  => "http://farm1.static.flickr.com/178/434774409_68abf27036_z.jpg?zz=1",
    :civ                  => "http://farm5.static.flickr.com/4056/4677750358_08f5df69e8_b.jpg",
    :crackle              => "http://3.bp.blogspot.com/-kiLO4-H2ICc/TxrPz6rL9OI/AAAAAAAALkA/r0SdZ1xL9zE/s1600/snapcracklepop.jpg?dur=878",
    :doublerainbow        => "http://www.doobybrain.com/wp-content/uploads/2010/07/double-rainbow.jpg",
    :earthcrisis97        => "http://farm6.static.flickr.com/5146/5773103819_97ceacd34f_b.jpg",
    :foo                  => "http://www.lasnark.com/wp-content/uploads/2010/12/foo-fighters-secret-show.jpg",
    :ilovecarrots         => "http://cdn.buzznet.com/media/jjr/headlines/2009/02/miley-cyrus-carrot-top.jpg",
    :kittens              => "http://cdn.uproxx.com/wp-content/uploads/2010/07/Kitten2.jpg",
    :lollipops            => "http://ny-image2.etsy.com/il_fullxfull.12765590.jpg",
    :ponies               => "http://h8.abload.de/img/irina_djangoponyo5dl.jpg",
    :radley               => "http://farm3.static.flickr.com/2440/3654633348_ee0b9ffe7c_z.jpg",
    :razorblades          => "http://farm1.static.flickr.com/220/468045907_e6097423da_b.jpg",
    :savesthedayisthebest => "http://i3.ytimg.com/vi/jtA0xhk-7oM/hqdefault.jpg",
    :shaners              => "http://iamshane.com/images/shane-becker-avatar-circle-xlarge.png",
    :siberianhuskie       => "http://farm1.static.flickr.com/74/163514301_1c9823d5cc_z.jpg?zz=1",
    :slingshot            => "http://farm1.static.flickr.com/77/163422937_3a1917def0_b.jpg",
    :snap                 => "http://www.prochoiceamerica.org/assets/images/snap-crackle-pop.jpg",
    :sxedude              => "http://farm3.static.flickr.com/2087/1567051898_bdfa75cd64_z.jpg?zz=1",
    :urchin               => "http://farm2.static.flickr.com/1194/832635950_601afd8a3e_b.jpg",
    :vegan                => "http://i196.photobucket.com/albums/aa236/xvladyx/DSC08164.jpg",
    :veganbookis          => "http://farm4.static.flickr.com/3287/3126230096_0c7d7e9f6f_z.jpg",
    :x                    => "http://farm4.static.flickr.com/3409/3472335277_108b35ab8f_b.jpg",
    :xpopx                => "http://www.chicagonow.com/stump-the-tromp/files/2011/06/snap-crackle-pop.jpg",
    :xtofux               => "http://farm3.static.flickr.com/2016/5704504989_6b91552765_b.jpg",
    :xveganx              => "http://i196.photobucket.com/albums/aa236/xvladyx/DSC06853.jpg",
    :xvx                  => "http://25.media.tumblr.com/A6DXfwmvQisoe82obmcZweqBo1_400.jpg",
    :youthcrew            => "http://img.photobucket.com/albums/v351/Marko138/livejournal/IMG_5078.jpg",
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
