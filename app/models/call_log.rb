class CallLog < ApplicationRecord
  belongs_to :user
	
  def self.save_call_log(params)
    log_atts = build_from_params(params)
    log = CallLog.find_by(call_sid: params[:CallSid])
    log.update_attributes(log_atts) if log.present?
    log
  end

  private
	
  def self.build_from_params(params)
    required_attr = %w(CallSid AccountSid From To CallStatus ApiVersion Direction ForwardedFrom)
    optional_attr = %w(FromCity FromState FromZip FromCountry ToCity ToState ToZip ToCountry CallDuration)
    all_attributes = required_attr + optional_attr 
    all_attributes.inject({}) { |memo, elm| memo.merge(elm.underscore.to_sym => params[elm]) }.delete_if { |_k, v| !v.present? }
  end
end
