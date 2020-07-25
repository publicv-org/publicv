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
    # TODO: Update experiences positions
    params[:order].each do |key,value|
      Experience.find(value[:id]).update_attribute(:position,value[:position])
    end
    render :nothing => true
    
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
<<<<<<< HEAD
end

=======
end
>>>>>>> b29bc292cd854a34d767a39c620b89bd3a40c388
