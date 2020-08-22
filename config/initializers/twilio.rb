Twilio.configure do |config|
  config.account_sid = ENV['TWILLIO_SID']
  config.auth_token = ENV['TWILLIO_TOKEN']
end
