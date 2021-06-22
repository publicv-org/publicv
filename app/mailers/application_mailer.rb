class ApplicationMailer < ActionMailer::Base
  include DefaultUrlOptions

  default from: ENV['MAIL_FROM']
  layout 'mailer'

  def mail_send(from: ENV['MAIL_FROM'], reply_to: ENV['MAIL_REPLY_TO'], to: nil,
                subject: nil, body: nil, tag: nil, cc: ENV['MAIL_REPLY_TO'])
    mail(from: from,
         reply_to: reply_to,
         to: to,
         subject: subject,
         body: body,
         tag: tag,
         cc: cc)
  end
end
