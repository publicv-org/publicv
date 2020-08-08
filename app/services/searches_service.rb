class SearchesService
  def initialize(search_results)
    @search_results = search_results
  end

  # :reek:FeatureEnvy
  def coordinates_list
    @search_results.map do |result|
      next if result.locations.empty?

      name = "#{result.user.first_name} #{result.user.last_name}"
      location = location_coordinates(result.locations.first)
      formatted_element(name, location)
    end.compact
  end

  def cluster_coords_list
    @search_results.map do |result|
      next if result.locations.empty?

      location = cluster_location_coordinates(result.locations.first)
      formatted_cluster(location)
    end.compact
  end

  private

  def formatted_element(name, location)
    {
      name: name,
      location: location
    }
  end

  def formatted_cluster(location)
    {
       "geometry": location 
    }
  end

  def cluster_location_coordinates(location)
    {
      coordinates: [location.longitude,location.latitude]
    }
  end

  def location_coordinates(location)
    {
      lng: location.longitude,
      lat: location.latitude
    }
  end
end
