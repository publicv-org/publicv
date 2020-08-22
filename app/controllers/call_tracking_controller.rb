class CallTrackingController < ApplicationController
  # This controller is accessed by twilio(Remote) server
  # So we don't need to verify authenticity token
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:user_selection_callback]

  def call_to_user
    user = User.last
    twiml = Twilio::Call.dial_to_user(user)
    redirect_back fallback_location: root_path 
  end
  
  def user_screen_call
    CallLog.save_call_log(params)
    twiml = Twilio::Call.get_user_screen_call_query(params)
    render xml: twiml.to_xml
  end

  def user_selection_callback
    office_selected = params[:Digits]
    if office_selected == '1'
      twiml = thankyou_msg_and_hangup
    elsif office_selected == '2'
      @user.cv.update_cv_status(2)
      twiml = thankyou_msg_and_hangup
    else
      twiml = Twilio::Call.get_user_screen_call_query(params, true)
    end
    render xml: twiml.to_xml
  end

  def status_callback
    CallLog.save_call_log(params)
    head :ok
  end
  
  private
  
  def thankyou_msg_and_hangup
    twiml = Twilio::TwiML::VoiceResponse.new do |r|
     r.say message: 'Thank you for you input.', voice: 'woman'
     r.say message: 'Call ended', voice: 'woman'
     r.hangup
    end
    twiml
 end
 
  def set_user
    user_number = params[:To]
    @user = User.find_by(tel: user_number)
  end
end