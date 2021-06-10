class UserMailer < ApplicationMailer
  def newsletter(resource_id, recipient_id)
    @newsletter = Newsletter.find_by(id: resource_id)
    @user = User.find_by(id: recipient_id)
    mail(to: @user.email,
         # from: "info@publicv.org",
         subject: t('mailer.subject'),
         tag: "newsletter_#{resource_id}")
  end
end
