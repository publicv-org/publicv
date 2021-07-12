class CvsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_cv, only: [:show]
  before_action :find_cv, only: %i[edit update download]
  respond_to :html, :js

  def show
    if request.path == root_path
      @cv_edit_controls = false # public view of CV on subdomain
    elsif current_user.present? && current_user.id == @cv.user_id
      @cv_edit_controls = params[:preview] != 't'
      @user = current_user
    else
      redirect_to root_domain_url
    end
  end

  def edit
    if Cv::CV_SECTIONS.include? params[:section]
      render "edit_#{params[:section]}"
    else
      redirect_to cv_section_path(current_user.subdomain)
    end
  end

  def update
    @user = current_user
    @cv_edit_controls = true

    respond_to do |format|
      if @cv.update(cv_params)
        format.html { redirect_to cv_section_path(@user.subdomain) }
        format.js {}
      else
        format.js { render 'errors' }
      end
    end
  end

  def download
    @cv_edit_controls = false
    pdf_html = ApplicationController.new.render_to_string(
      template: 'cvs/printings/show',
      locals: { :@cv => @cv, :@cv_edit_controls => @cv_edit_controls, :@user => current_user },
      layout: 'pdf'
    )
    pdf = WickedPdf.new.pdf_from_string(pdf_html, footer: { left: '[page] / [topage]' })
    send_data pdf, filename: 'cv.pdf'
  end

  private

  def set_cv
    @user = User.find_by(subdomain: subdomain)
    if @user
      @cv = @user.cv
    else
      redirect_to root_domain_url
    end
  end

  def find_cv
    @cv = if params[:id]
            Cv.find_by(id: params[:id], user_id: current_user.id)
          else
            current_user.cv
          end
  end

  def cv_params
    params.require(:cv).permit(:about, :birth_date, :birth_place, :birth_day, :birth_month, :birth_year, :future_plans,
                               :gender, :headshot, :interests, :published, :section, :skills, :working_skills,
                               :learning_skills, :remove_headshot, :authorization_statement, :publish_last_name,
                               user_attributes: [:id, :first_name, :last_name, :tel,
                                                 current_location_attributes: %i[id original_address]])
  end

  def subdomain
    return params[:subdomain] unless ENV['SERVER_ENV'] == 'production'

    request.subdomain.presence || params[:subdomain]
  end
end
