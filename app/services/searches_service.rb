class SearchesService
  def initialize(search_results)
    @search_results = search_results
  end

  # :reek:FeatureEnvy
  def coordinates_list
    @search_results.map do |result|
      next if result.locations.empty?

      name = result.abbr_name
      subdomain = result.subdomain
      location = location_coordinates(result.locations.first)
      formatted_element(name, location, subdomain)
    end.compact
  end

  private

  def formatted_element(name, location, subdomain)
    {
      name: name,
      location: location,
      subdomain: subdomain
    }
  end

  def location_coordinates(location)
    {
      lng: location.longitude,
      lat: location.latitude
    }
  end
end
