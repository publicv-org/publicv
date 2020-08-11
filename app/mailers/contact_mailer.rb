class ContactMailer < ApplicationMailer
  # Hire candidate notification
  def send_notification_to_candidate(user_id, contact_id)
    @user = User.find_by(id: user_id)
    @contact = Contact.find_by(id: contact_id)
    @current_locale = @user.locale
    mail(to: @user.email, subject: "[PubliCV] #{@contact.name}")
  end
end
