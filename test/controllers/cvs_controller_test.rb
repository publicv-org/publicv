require 'test_helper'

class CvsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in(@user)
  end

  test 'GET #show returns a success response' do
    get cv_section_path(@user.subdomain)
    assert_response :success
  end

  test 'only predefined sections can be edited' do
    get edit_cv_section_path(section: 'summary'), xhr: true
    assert_response :success

    get edit_cv_section_path(section: 'personal_info'), xhr: true
    assert_response :redirect
    assert_redirected_to cv_section_path(@user.subdomain)
  end

  test 'cv should only get updated with valid attributes' do
    valid_params = { cv: { about: 'This is a new description' } }
    put cv_path(valid_params), xhr: true
    assert_response :success
    assert_template :update

    about = Faker::Lorem.paragraph(256..260)
    invalid_params = { cv: { about: about } }
    put cv_path(invalid_params), xhr: true
    assert_response :success
    assert_template 'cvs/errors'
  end
end
