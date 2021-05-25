class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def update
    current_user.update(permitted_preferences_params)
    @box_flash_message = box_flash_message

    respond_to do |format|
      format.js {}
      format.html { redirect_to request.referer }
    end
  end

  def show
    @email_preferences = @options[:user].class.name.constantize::EMAIL_PREFERENCES
  end

  # def unsubscribe
  #   Mailkick.opt_out(@options)
  #   if @options[:loggable_type] && @options[:loggable_id].present?
  #     mailkick_opt_out = Mailkick::OptOut.find_by(user: @options[:user])
  #     mailkick_opt_out.update_columns(loggable_type: @options[:loggable_type], loggable_id: @options[:loggable_id])
  #   end
  #   redirect_to preference_path(params[:id])
  # end

  # def update
  #   @options[:user].update(permitted_preferences_params)
  #   head :ok
  # end

  private

  # def set_email
  #   @email, user_id, user_type, @list = Mailkick.message_verifier.verify(params[:id])
  #   if user_type
  #     # on the unprobabilistic chance user_type is compromised, not much damage
  #     @user = user_type.constantize.find(user_id)
  #   end
  #   @options = {
  #     email: @email,
  #     user: @user,
  #     list: @list[:preference_type],
  #     loggable_type: @list[:loggable_type],
  #     loggable_id: @list[:loggable_id]
  #   }
  # rescue ActiveSupport::MessageVerifier::InvalidSignature
  #   render plain: "Link Scaduto o non valido", status: :bad_request
  # end

  def permitted_preferences_params
    params.require(:emails).permit(User::EMAIL_PREFERENCES)
  end

  def box_flash_message
    return t('.multiple') if permitted_preferences_params.keys.size > 1

    t(".#{permitted_preferences_params.keys.first}_#{permitted_preferences_params.values.first}")
  end
end
