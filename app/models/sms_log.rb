class SmsLog < ApplicationRecord
  belongs_to :user

  def self.save_sms_log(params)  
    log_atts = build_from_params(params)
    user_number = (params[:sms_status] == 'received') ? params[:From] : params[:To]
    user = User.find_by(tel: user_number)
    log = SmsLog.where(sms_sid: params[:SmsSid]).first
    if log
      log.update_attributes(log_atts)
    else
      log = user.sms_logs.create(log_atts) if user.present?
    end
    log
  end
 
  def self.build_from_params(params)
    required_attr = %w(SmsSid AccountSid From To SmsStatus Body ApiVersion Direction ForwardedFrom)
    optional_attr = %w(FromCity FromState FromZip FromCountry ToCity ToState ToZip ToCountry)
    all_attributes = required_attr + optional_attr
    all_attributes.inject({}) { |memo, elm| memo.merge(elm.underscore.to_sym => params[elm]) }.delete_if { |_k, v| !v.present? }
  end 
end
