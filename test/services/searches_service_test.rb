require 'test_helper'

class SearchesServiceTest < ActionView::TestCase
  test 'coordinates_list with no search results' do
    full_text_search_results = []
    locations_list = []

    assert_equal locations_list, SearchesService.new(full_text_search_results).coordinates_list
  end

  test 'coordinates_list with location/s available' do
    latitude = 40.7143528
    longitude = -74.0059731
    name = 'John Williams'
    full_text_search_results = [cvs(:john_cv)]
    locations_list = [
      {
        name: name,
        location: {
          lat: latitude,
          lng: longitude
        }
      }
    ]

    assert_equal locations_list, SearchesService.new(full_text_search_results).coordinates_list
  end

  test 'coordinates_list with no location/s available' do
    full_text_search_results = [cvs(:search_user_cv)]
    locations_list = []

    assert_equal locations_list, SearchesService.new(full_text_search_results).coordinates_list
  end
end
