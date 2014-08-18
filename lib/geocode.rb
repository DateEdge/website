class Geocode

  def initialize(address)
    @address = address
  end

  def lat_lng
    lookup["results"].first["geometry"]["location"]
  end

  def query_string
    {
      key: "AIzaSyBUsS11chK_veOLCCks6o2U2jp1XDD6wgU",
      address: @address
    }.to_query
  end

  def uri
    URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{query_string}")
  end

  def valid?
    lookup["results"].any?
  end

  def lookup
    @lookup ||= parse_response Net::HTTP.get(uri)
  end

  def parse_response(response)
    JSON.parse response
  end
end
