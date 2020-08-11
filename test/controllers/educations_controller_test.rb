require 'test_helper'

class EducationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in(@user)
  end

  test 'GET#new should returns a success response' do
    get new_cv_education_path, xhr: true
    assert_response :success
  end

  test 'GET#edit should returns a success response' do
    education = educations(:john_education)
    get edit_cv_education_path(education), xhr: true
    assert_response :success
  end

  test 'education should only get created with valid attributes' do
    valid_params = { education: { school: Faker::Name.name } }
    assert_difference('Education.count') do
      post cv_educations_path(valid_params), xhr: true
    end
    assert_response :success
    assert_template :index

    invalid_params = { education: { school: nil } }
    assert_no_difference('Education.count') do
      post cv_educations_path(invalid_params), xhr: true
    end
    assert_response :success
    assert_template 'educations/errors'
  end

  test 'education should only get updated with valid attributes' do
    education = educations(:john_education)

    valid_params = { education: { degree: 'Master of Science' } }
    put cv_education_path(education, valid_params), xhr: true

    education.reload
    assert_equal 'Master of Science', education.degree
    assert_response :success
    assert_template :index

    invalid_params = { education: { school: nil, degree: 'Master of Computers' } }
    put cv_education_path(education, invalid_params), xhr: true

    education.reload
    assert_not_equal 'Master of Computers', education.degree
    assert_response :success
    assert_template 'educations/errors'
  end

  test 'education can be deleted' do
    education = educations(:john_education)
    assert_difference('Education.count', -1) do
      delete cv_education_path(education)
    end

    assert_response :redirect
    assert_redirected_to cv_section_path(@user.subdomain)
  end
end
