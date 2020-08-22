require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Publicv
  class Application < Rails::Application
    config.load_defaults 5.2

    config.time_zone = 'Rome'
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # whitelist twilio IP to allow twilio request communicate with our app
    config.web_console.whitelisted_ips = '34.207.216.154'
    # config.action_mailer.default_url_options = { host: ENV['APP_HOST'], port: ENV['APP_PORT'] }
    config.active_job.queue_adapter = :sidekiq
  end
end
