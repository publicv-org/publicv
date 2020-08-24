class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cv
  before_action :set_experience, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:update_positions]

  respond_to :html, :js

  def new
    @experience = Experience.new
  end

  def edit; end

  def create
    @experience = @cv.experiences.build(experience_params)
    respond_to do |format|
      if @experience.save
        format.js { render 'index' }
      else
        format.js { render 'experiences/errors' }
      end
    end
  end

  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.js { render 'index' }
      else
        format.js { render 'experiences/errors' }
      end
    end
  end

  def update_positions
    params[:experience].each_with_index do |exp_id, index|
      experience = Experience.find_by(id: exp_id)
      experience&.update!(position: index)
    end

    @cv.update(custom_experience_sort: true) if params[:experience].present?

    head :ok
  end

  def destroy
    @experience.destroy
    redirect_to cv_section_path(current_user.subdomain), flash: { success: t('success.experience.destroy') }
  end

  private

  def set_cv
    @cv = current_user.cv
    @cv_edit_controls = true
  end

  def set_experience
    @experience = @cv.experiences.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:company, :description, :ended_on, :location, :started_on, :title, :website_url)
  end
end
