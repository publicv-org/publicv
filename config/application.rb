require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Publicv
  class Application < Rails::Application
    config.load_defaults 5.2

    config.time_zone = 'Rome'
    config.i18n.default_locale = :en
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # config.action_mailer.default_url_options = { host: ENV['APP_HOST'], port: ENV['APP_PORT'] }
    config.active_record.schema_format = :sql
  end
end
