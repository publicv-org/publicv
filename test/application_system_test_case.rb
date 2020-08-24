require 'test_helper'
require 'support/i18n_helpers'
require 'support/wait_for_ajax'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  include I18nHelpers
  include WaitForAjax

  private

  def manual_sign_in(email, password = 'supersecret')
    visit new_user_session_url
    within(:css, '#new_user') do
      fill_in('user_email', with: email)
      fill_in('user_password', with: password)
      click_button('user_log_in')
    end
  end
end
