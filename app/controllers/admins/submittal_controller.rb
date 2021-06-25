module Admins
  class SubmittalController < ApplicationController
    before_action :authenticate_user!
    def create
      authorize :submittal
      newsletter = Newsletter.find_by(id: params[:newsletter_id])
      newsletter.recipient_ids.split(',').map(&:to_i).each do |recipient_id|
        if set_preferences(newsletter.id, recipient_id)
          UserMailer.newsletter(newsletter.id, recipient_id).deliver_later
          newsletter.update(sent_at: Time.current)
        end
      end
      redirect_to admins_newsletters_path
    end

    def set_preferences(_newsletter_id, recipient_id)
      user = User.find_by(id: recipient_id)
      if user.email_preference_online_updates == true
        true
      else
        flash[:alert] = I18n.t('flash.send_newsletter')
        false
      end
    end
  end
end
