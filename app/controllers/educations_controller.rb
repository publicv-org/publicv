class EducationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cv
  before_action :set_education, only: %i[edit update destroy]
  skip_before_action :verify_authenticity_token, only: [:update_positions]

  respond_to :html, :js

  def new
    @education = Education.new
  end

  def edit; end

  def create
    @education = @cv.educations.build(education_params)
    respond_to do |format|
      if @education.save
        format.js { render 'index' }
      else
        format.js { render 'educations/errors' }
      end
    end
  end

  def update
    respond_to do |format|
      if @education.update(education_params)
        format.js { render 'index' }
      else
        format.js { render 'educations/errors' }
      end
    end
  end

  def update_positions
    sort_edu_params = JSON.parse(params[:education])
    sort_edu_params.each_with_index do |edu_id, index|
      education = Education.find_by(id: edu_id)
      education&.update!(position: index)
    end

    @cv.update(custom_education_sort: true) if params[:education].present?

    head :ok
  end

  def destroy
    @education.destroy
    redirect_to cv_section_path(current_user.subdomain), flash: { success: t('success.education.destroy') }
  end

  private

  def set_cv
    @cv = current_user.cv
    @cv_edit_controls = true
  end

  def set_education
    @education = @cv.educations.find(params[:id])
  end

  def education_params
    params.require(:education).permit(:degree, :description, :ended_on, :school, :started_on)
  end
end
