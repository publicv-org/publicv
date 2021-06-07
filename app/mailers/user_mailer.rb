class UserMailer < ApplicationMailer
  def newsletter(newsletter_id, recipient_id)
    @newsletter = Newsletter.find_by(id: newsletter_id)
    @user = User.find_by(id: recipient_id)
    mail(to: @user.email,
         # from: "info@publicv.org",
         subject: t('mailer.subject'),
         tag: "newsletter_#{newsletter_id}")
  end
end
