class ContactUserJob < ApplicationJob
  def perform(user_id)
    user = User.find_by(id: user_id)
    if user.present? && user.this_month_incomming_sms_logs.count < 1 
      Twilio::Sms.send_sms(user) if user.this_month_outgoing_sms_logs.count < 2 
      Twilio::Call.dial_to_user(user) if user.this_month_sms_logs.count == 2
    end
  end
end