require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'user registeration with all permitted params' do
    user_params = { user: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                            subdomain: Faker::Name.first_name, email: Faker::Internet.email,
                            tel: Faker::PhoneNumber.cell_phone, password: 'Password123',
                            password_confirmation: 'Password123' } }

    assert_difference('ActionMailer::Base.deliveries.count') do
      assert_difference('User.count') do
        post user_registration_path(user_params)
      end
    end
  end
end
