module Users
  class PreferencesController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_user_type

    def index; end

    def update
      current_user.update(permitted_preferences_params)
      redirect_back(fallback_location: users_preferences_path, notice: box_flash_message)
    end

    private

    def authenticate_user_type
      authorize :preference
    end

    def permitted_preferences_params
      params.require(:emails).permit(User::EMAIL_PREFERENCES)
    end

    def box_flash_message
      return t('.multiple') if permitted_preferences_params.keys.size > 1

      t(".#{permitted_preferences_params.keys.first}_#{permitted_preferences_params.values.first}")
    end
  end
end
