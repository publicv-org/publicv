module Admins
  class SubmittalController < ApplicationController
    def create
      newsletter = Newsletter.find_by(id: params[:newsletter_id])
      newsletter.recipient_ids.split(',').map(&:to_i).each do |recipient_id|
        if spam_errors_check(newsletter.id, recipient_id)
          UserMailer.newsletter(newsletter.id, recipient_id).deliver_later
          newsletter.update(sent_at: Time.current)
        end
      end
      redirect_to admins_newsletters_path
    end

    private

    def spam_errors_check(newsletter_id, recipient_id)
      newsletter = Newsletter.find_by(id: newsletter_id)
      mailz = ApplicationMailer.mail_send(from: ENV['MAIL_FROM'],
                                          subject: newsletter.subject,
                                          tag: "newsletter_#{recipient_id}",
                                          body: newsletter.content)
      spam_check = Postmark::SpamCheck.check(mailz.to_s)
      new_score = spam_check.score
      spam_check.details.each do |point|
        if point[:rule] == 'MISSING_HEADERS'
          new_score = new_score.to_f - point[:points].to_f
          break
        end
      end
      spam_check.details.delete_if { |detail| detail[:rule] == 'MISSING_HEADERS' }
      if ENV['SPAM_SCORE'].to_f > new_score
        newsletter.update(status: 1, spam_errors: spam_check.error)
        flash[:success] = 'Newsletter sent successfully'
        true
      else
        errors = []
        spam_check.details.each do |x|
          errors.push(x[:description])
        end
        newsletter.update(status: 0, spam_errors: errors)
        flash[:alert] = newsletter.spam_errors.each { |error| puts error }
        false
      end
    end
  end
end
