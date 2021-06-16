class PreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_email

  def show
    @email_preferences = @options[:user].class.name.constantize::EMAIL_PREFERENCES
  end

  def unsubscribe
    Mailkick.opt_out(@options)
    redirect_to preference_path(params[:id])
  end

  def update
    @options[:user].update(permitted_preferences_params)
    head :ok
  end

  private

  def permitted_preferences_params
    params.require(:emails).permit(User::EMAIL_PREFERENCES)
  end

  def set_email
    @email, user_id, user_type = Mailkick.message_verifier.verify(params[:id])
    @user = user_type.constantize.find(user_id)
    @options = {
      email: @email,
      user: @user
    }
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    render plain: 'Link expired or invalid', status: :bad_request
  end
end
