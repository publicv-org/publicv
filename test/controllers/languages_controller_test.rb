require 'test_helper'

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in(@user)
  end

  test 'GET#new should returns a success response' do
    get new_cv_language_path, xhr: true
    assert_response :success
  end

  test 'GET#edit should returns a success response' do
    language = languages(:english)
    get edit_cv_language_path(language), xhr: true
    assert_response :success
  end

  test 'language should only get created with valid attributes' do
    valid_params = { language: { language: 'italian', level: 'a1' } }
    assert_difference('Language.count') do
      post cv_languages_path(valid_params), xhr: true
    end
    assert_response :success
    assert_template :index

    invalid_params = { language: { language: 'french' } }
    assert_no_difference('Language.count') do
      post cv_languages_path(invalid_params), xhr: true
    end
    assert_response :success
    assert_template 'languages/errors'
  end

  test 'language should only get updated with valid attributes' do
    language = languages(:english)

    valid_params = { language: { level: 'c1' } }
    put cv_language_path(language, valid_params), xhr: true

    language.reload
    assert_equal 'c1', language.level
    assert_response :success
    assert_template :index

    invalid_params = { language: { language: nil, level: 'ab1' } }
    put cv_language_path(language, invalid_params), xhr: true

    language.reload
    assert_not_equal 'ab1', language.level
    assert_response :success
    assert_template 'languages/errors'
  end

  test 'language can be deleted' do
    language = languages(:english)
    assert_difference('Language.count', -1) do
      delete cv_language_path language
    end

    assert_response :redirect
    assert_redirected_to cv_section_path(@user.subdomain)
  end
end
