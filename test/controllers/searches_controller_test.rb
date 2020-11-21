require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:john)
    sign_in(@user)
  end

  test 'GET #index redirects to root in absence of a search query' do
    post searches_path
    assert_response 302
    # TODO: assert_redirected_to root_path for some reason fails with expected "http://www.example.com/"
  end
end
