module Twilio
  class Call
    include Twilio::Intializer
    DIAL_RESPONSE_TIME = '3600'.freeze
    SELECTION_TIMEOUT = 12

    CALL_STATUS_CALLBACK = "#{ENV['HOST_URL']}/call_tracking/status_callback".freeze
    SCREEN_CALL_RESPONSE_CALLBACK = "#{ENV['HOST_URL']}/call_tracking/user_screen_call_response".freeze
    USER_SCREEN_CALL_CALLBACK = "#{ENV['HOST_URL']}/call_tracking/user_screen_call".freeze
    USER_SELECTION_CALLBACK = "#{ENV['HOST_URL']}/call_tracking/user_selection_callback".freeze
    VOICE='woman'
    
    def self.dial_to_user(user)
      number_to_call = user.tel
      twilio_phone_number = ENV['TWILIO_NUMBER']
      twiml = @client.calls.create(from: twilio_phone_number, to: number_to_call,
                            url: USER_SCREEN_CALL_CALLBACK,
                            status_callback: CALL_STATUS_CALLBACK,
                            status_callback_method: 'POST')
      user = User.last
      build_params= {call_sid: twiml.sid, account_sid: twiml.account_sid, to: twiml.to, from: twiml.from}
      call_log = user.call_logs.create(build_params)
      twiml
    end

    def self.get_user_screen_call_query(params, invalid_input = false)
      twiml = Twilio::TwiML::VoiceResponse.new do |r|
        r.gather numDigits: '1', action: USER_SELECTION_CALLBACK, method: 'GET', timeout: SELECTION_TIMEOUT, finishOnKey: '*' do |g|
          g.say message: 'you have entered invalid input', voice: VOICE if invalid_input
          # g.say message: '', voice: VOICE unless invalid_input
          g.say message: 'Hi, this call is from Public CV. your cv is open, are you still looking for job? press 1 for Yes or press 2 For No', voice: VOICE
        end

        # will return status no-answer since this is a Number callback
        r.say message: "Sorry, We didn't get your response." , voice: VOICE
        r.hangup
      end
      twiml
    end
  end
end