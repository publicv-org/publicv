class HomeController < ApplicationController
  before_action :set_current_location, only: [:index]

  def index
    @featured_cvs = Cv.published.headshot_present.order(updated_at: :desc)
    @cvs_last_updated_count = Cv.where('updated_at > ?', 30.days.ago).count
    @formatted_results = SearchesService.new(@featured_cvs).coordinates_list
  end

  def set_current_location
    loc = Geocoder.search(request.remote_ip).first
    @coordinates = loc.data['error'].present? || loc.data.empty? ? default_coordinates : [loc.longitude, loc.latitude]
  end

  private

  def default_coordinates
    locale.to_s == 'it' ? [12.5674, 41.8719] : [77.2219388, 28.6517178]
  end
end
