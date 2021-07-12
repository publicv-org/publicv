class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :root_domain_url
  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: I18n.t('flash.authorization') }
    end
  end

  def seo_tags_for(resource)
    @seo_title = resource.seo_title
    # TODO: @seo_description = resource.seo_description
  end

  protected

  def configure_permitted_parameters
    params[:user][:locale] = I18n.locale if params[:user].present?
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name tel subdomain locale])
  end

  def set_locale
    return I18n.locale = ENV['DEVELOPMENT_LOCALE'].to_sym if ENV['DEVELOPMENT_LOCALE'].present?

    I18n.locale = case tld
                  when 'it'
                    :it
                  else
                    :en
                  end
  end

  def after_sign_in_path_for(resource)
    cv_section_path(resource.subdomain)
  end

  def tld
    @tld ||= request.host.split('.').last
  end

  def root_domain_url
    locale.to_s == 'en' ? ENV['EN_SERVER_HOST'] : ENV['IT_SERVER_HOST']
  end
end
