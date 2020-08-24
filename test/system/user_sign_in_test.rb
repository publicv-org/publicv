require 'test_helper'

class UserSignInTest < ApplicationSystemTestCase
  driven_by :selenium_chrome_headless

  setup do
    @user = users(:john)
  end

  test 'user can sign_in' do
    manual_sign_in(@user.email)
    assert_current_path cv_section_path(@user.subdomain)
  end
end
