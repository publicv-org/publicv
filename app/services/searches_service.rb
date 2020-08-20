class SearchesService
  def initialize(search_results)
    @search_results = search_results
  end

  # :reek:FeatureEnvy
  def coordinates_list
    @search_results.map do |result|
      next if result.locations.empty?


      subdomain = result.subdomain
      name = location_names(result.abbr_name, subdomain)
      location = location_coordinates(result.locations.first)
      formatted_element(name, location)
    end.compact
  end

  private

  def formatted_element(name, location)
    {
      "geometry": location,
      "properties": name
    }
  end

  def location_coordinates(location)
    {
      coordinates: [location.longitude,location.latitude]
    }
  end

  def location_names(name, subdomain)
    {
      name: name,
      subdomain: subdomain
    }
  end
end
