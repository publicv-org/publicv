class ApplicationMailer < ActionMailer::Base
  include DefaultUrlOptions

  default from: ENV['MAIL_FROM']
  layout 'mailer'
end
