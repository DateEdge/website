class LatLngsSerializer
  def initialize(collection)
    @collection = collection
  end

  def to_h
    {lat_lngs: collection}
  end

  def collection
    @collection.map {|ll| {
      id:       ll.id,
      lat:      ll.lat,
      lng:      ll.lng,
      username: ll.user.username,
      location: ll.user.location,
      avatar:   ll.user.avatar,
      user_id:  ll.user_id
    } }
  end

end
