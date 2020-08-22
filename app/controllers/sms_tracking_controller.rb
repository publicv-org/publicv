class SmsTrackingController < ApplicationController
  # This controller is accessed by twilio(Remote) server
  # So we don't need to verify authenticity token
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:sms_request]

  def sms_request
    reply = params[:body]
    log = SmsLog.save_sms_log(params)
    current_month_sms_logs = user.this_month_sms_logs
    if @user.present? && reply.lowercase == 'no'
      @user.cv.update_cv_status(2)
    end
    head :ok
  end
  
  def status_callback
    SmsLog.save_sms_log(params)
    head :ok
  end

  private

  def set_user
    user_number = params[:SmsSatus] == 'recieved' ? params[:From] : params[:To]
    @user = User.find_by(tel: user_number)
  end
end