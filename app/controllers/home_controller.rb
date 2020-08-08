class HomeController < ApplicationController
  before_action :set_current_location, only: [:index]

  def index
    near_by_cvs # Fetch cvs near by to user current location within radius of 500 Km
    @cvs_last_updated_count = Cv.where('updated_at > ?', 30.days.ago).count
    @formatted_results = SearchesService.new(@cvs).coordinates_list
    @cluster_results = SearchesService.new(@cvs).cluster_coords_list
  end

  def set_current_location
    loc = Geocoder.search(request.remote_ip).first
    @coordinates = loc.data['error'].present? || loc.data.empty? ? default_coordinates : [loc.longitude, loc.latitude]
  end

  # Note: Distance is in miles
  def near_by_cvs
    @loc_id = Location.within(311, :units => :kms, :origin => [@coordinates[1], @coordinates[0]]) 
    @cvs =  Cv.where(:id => @loc_id.ids)
  end

  private

  def default_coordinates
    locale.to_s == 'it' ? [12.5674, 41.8719] : [77.2219388, 28.6517178]
  end
end