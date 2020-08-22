module Twilio
  class Sms
    include Twilio::Intializer
    CALL_STATUS_CALLBACK = "#{ENV['HOST_URL']}/sms_tracking/status_callback".freeze
    def self.send_sms(user)
      to_number = user.tel
      twilio_number = ENV['TWILIO_NUMBER']
      twiml = @client.messages.create(
                               body: "Hi #{user.first_name}, your cv is open, are you still looking for job reply YES OR NO",
                               from: twilio_number,
                               to: to_number,
                               status_callback: CALL_STATUS_CALLBACK
                             )
      
      build_params= {sms_sid: twiml.sid, account_sid: twiml.account_sid, to: twiml.to, from: twiml.from}
      sms_log = user.sms_logs.create(build_params)
    end
  end
end

