require 'test_helper'

class ExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in(@user)
  end

  test 'GET#new should returns a success response' do
    get new_cv_experience_path, xhr: true
    assert_response :success
  end

  test 'GET#edit should returns a success response' do
    experience = experiences(:john_experience)
    get edit_cv_experience_path(experience), xhr: true
    assert_response :success
  end

  test 'experience should only get created with valid attributes' do
    valid_params = { experience: { title: 'Developer', company: Faker::Company.name } }
    assert_difference('Experience.count') do
      post cv_experiences_path(valid_params), xhr: true
    end
    assert_response :success
    assert_template :index

    invalid_params = { experience: { title: nil } }
    assert_no_difference('Experience.count') do
      post cv_experiences_path(invalid_params), xhr: true
    end
    assert_response :success
    assert_template 'experiences/errors'
  end

  test 'experience should only get updated with valid attributes' do
    experience = experiences(:john_experience)

    valid_params = { experience: { description: 'Developing web applications' } }
    put cv_experience_path(experience, valid_params), xhr: true

    experience.reload
    assert_equal 'Developing web applications', experience.description
    assert_response :success
    assert_template :index

    invalid_params = { experience: { company: nil, description: 'Developing applications' } }
    put cv_experience_path(experience, invalid_params), xhr: true

    experience.reload
    assert_not_equal 'Developing applications', experience.description
    assert_response :success
    assert_template 'experiences/errors'
  end

  test 'experience can be deleted' do
    experience = experiences(:john_experience)
    assert_difference('Experience.count', -1) do
      delete cv_experience_path experience
    end

    assert_response :redirect
    assert_redirected_to cv_section_path(@user.subdomain)
  end
end
