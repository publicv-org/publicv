ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'
require_relative '../config/environment'
require 'rails/test_help'
require 'application_system_test_case'

require 'minitest/reporters'

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  %w[headless window-size=1280x1280 disable-gpu].each { |arg| options.add_argument(arg) }
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.save_path = Rails.root.join('tmp', 'capybara')
Capybara.default_max_wait_time = 5

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
    # order.
    fixtures :all
  end
end

module ActionDispatch
  class IntegrationTest
    include Devise::Test::IntegrationHelpers
    include Warden::Test::Helpers

    def sign_in(user, user_password = 'supersecret')
      post user_session_path \
        'user[email]' => user.email,
        'user[password]' => user_password
    end
  end
end

module ActionMailer
  class TestCase
    include I18nHelpers
  end
end

# Remove test_files after run
# (test_files are where paperclip attachments are saved during tests)
Minitest.after_run do
  FileUtils.rm_rf(Dir[Rails.root.join('tmp', 'test_files')])
end
