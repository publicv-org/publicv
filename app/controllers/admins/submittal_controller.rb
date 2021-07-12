module Admins
  class SubmittalController < ApplicationController
    authorize_resource class: 'Newsletter'

    def create
      newsletter = Newsletter.find_by(id: params[:newsletter_id])
      opted_user_ids = []
      recipient_ids = newsletter.recipient_ids.split(',').map(&:to_i)
      recipient_ids.each do |recipient_id|
        next unless user_opted_for_email_preference(newsletter.preference_type, recipient_id)

        opted_user_ids << recipient_id
        UserMailer.newsletter(newsletter.id, recipient_id).deliver_later
        newsletter.update(sent_at: Time.current)
      end
      opt_out_user_ids = recipient_ids - opted_user_ids
      flash[:info] = t('.success', opted_user_ids: opted_user_ids.join(','), scope: :flash)
      flash[:info] += t('.fail', opt_out_user_ids: opt_out_user_ids.join(','), scope: :flash) if opt_out_user_ids.any?
      redirect_to admins_newsletters_path
    end

    def user_opted_for_email_preference(preference_type, recipient_id)
      user = User.find_by(id: recipient_id)
      user.send(preference_type)
    end
  end
end
