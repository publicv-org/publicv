module Admins
  class SubmittalController < ApplicationController
    def create
      newsletter = Newsletter.find(params[:newsletter_id])
      newsletter.update(sent_at: Time.current)
      newsletter.recipient_ids.split(',').map(&:to_i).each do |recipient_id|
        UserMailer.newsletter(newsletter.id, recipient_id).deliver_later
      end
    end
  end
end
