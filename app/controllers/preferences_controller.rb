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

  private

  def permitted_preferences_params
    params.require(:emails).permit(User::EMAIL_PREFERENCES)
  end

  def box_flash_message
    return t('.multiple') if permitted_preferences_params.keys.size > 1

    t(".#{permitted_preferences_params.keys.first}_#{permitted_preferences_params.values.first}")
  end
end
