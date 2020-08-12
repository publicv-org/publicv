Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_SITE_KEY_V2']
  config.secret_key = ENV['RECAPTCHA_SECRET_KEY_V2']
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
