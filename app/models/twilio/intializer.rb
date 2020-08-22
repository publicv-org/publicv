module Twilio::Intializer
  extend ActiveSupport::Concern

  included do
    @client = Twilio::REST::Client.new
  end

end
