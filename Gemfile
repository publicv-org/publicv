source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.0'
# ruby File.read('.ruby-version')

gem 'bootsnap', '>= 1.1.0', require: false
gem 'devise'
gem 'devise-i18n'
gem 'figaro'
gem 'friendly_id', '~> 5.4.0'
gem 'geocoder'
gem 'jbuilder', '~> 2.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search'
gem 'puma', '~> 3.12'
gem 'pundit'
gem 'rails', '~> 5.2.1'
gem 'rails-i18n'
# gem 'slim-rails'
gem 'paperclip'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpacker', '~> 3.5'
# Amazon S3
gem 'aws-sdk-s3'
gem 'kaminari'
gem 'maxminddb' # GeoLite2 City database for local IP geocoding
# Basic functionality
gem 'mailgun-ruby', '~>1.2.0'
gem 'recaptcha'
# PDF generation
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary-edge'
# editor
gem 'trix-rails', require: 'trix'
# Email unsubscribe
gem 'mailkick'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'i18n-tasks', '~> 0.9.31'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
  gem 'slim_lint', require: false
end

group :test do
  gem 'capybara'
  gem 'capybara-selenium'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'minitest-reporters', '~> 1.0.5'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :production do
  gem 'lograge'
  gem 'newrelic_rpm'
  gem 'wkhtmltopdf-heroku'
end
