module ApplicationHelper
  def seo_title
    return 'PubliCV' unless @seo_title
    return "#{@seo_title} @ PubliCV" unless home?

    @seo_title
  end

  private

  def home?
    controller_name == 'home' && action_name == 'index'
  end
end
