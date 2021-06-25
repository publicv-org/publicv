Mailkick::OptOut.class_eval do
  after_save :update_preference

  private

  def update_preference
    user.update list.to_sym => !active
  end
end
