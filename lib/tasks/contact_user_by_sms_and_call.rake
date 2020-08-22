namespace :contact_user_by_sms_and_call do
  desc 'Call or sms to user for active Cvs'
  task contact: :environment do
    Cv.published.each do |cv|
      ContactUserJob.perform_later(cv.user_id)
    end
  end
end