# require 'test_helper'

# class LocationsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @user = users(:john)
#     sign_in(@user)
#   end

#   test 'GET#new should returns a success response' do
#     get new_location_path, xhr: true
#     assert_response :success
#   end

#   test 'GET#edit should returns a success response' do
#     location = locations(:new_york)
#     get edit_location_path(location), xhr: true
#     assert_response :success
#   end

#   test 'location should only get created with valid attributes' do
#     valid_params = { location: { original_address: Faker::Address.full_address } }
#     assert_difference('Location.count') do
#       post locations_path(valid_params), xhr: true
#     end
#     assert_response :success
#     assert_template :index

#     invalid_params = { location: { original_address: nil } }
#     assert_no_difference('Location.count') do
#       post locations_path(invalid_params), xhr: true
#     end
#     assert_response :success
#     assert_template 'locations/errors'
#   end

#   test 'location should only get updated with valid attributes' do
#     location = locations(:new_york)

#     valid_params = { location: { original_address: 'Bahnhofplatz 17, 8400 Winterthur' } }
#     put location_path(location, valid_params), xhr: true

#     location.reload
#     assert_equal 'Bahnhofplatz 17, 8400 Winterthur', location.original_address
#     assert_response :success
#     assert_template :index

#     invalid_params = { location: { original_address: nil, radius: 4 } }
#     put location_path(location, invalid_params), xhr: true

#     location.reload
#     assert_not_equal 4, location.radius
#     assert_response :success
#     assert_template 'locations/errors'
#   end

#   test 'location can be deleted' do
#     location = locations(:new_york)
#     assert_difference('Location.count', -1) do
#       delete location_path(location)
#     end

#     assert_response :redirect
#     assert_redirected_to cv_section_path(@user.subdomain)
#   end
# end
