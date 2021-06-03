class NewslettersController < ApplicationController
  before_action :set_newsletter, only: %i[edit update] # statistics
  before_action :authenticate_user!

  def index
    @newsletter = Newsletter.order(:created_at).page(params[:page])
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new(newsletter_params)
    if @newsletter.save
      update_attachments
      flash[:success] = I18n.t('flash.create', resource_name: @newsletter)
      redirect_to newsletters_path
    else
      render :new
    end
  end

  def edit; end

  def update
    update_attachments
    if @newsletter.update(newsletter_params)
      flash[:success] = I18n.t('flash.update', resource_name: @newsletter)
      redirect_to newsletters_path
    else
      render :edit
    end
  end

  private

  def set_newsletter
    @newsletter = Newsletter.find(params[:id]) # .friendly
  end

  def update_attachments
    params[:newsletter][:attachments].each do |x , y|
      a = Attachment.find_by(id: y.keys)
      a.update(newsletter_id: @newsletter.id)
    end
  end

  def newsletter_params
    params.require(:newsletter).permit(:name, :subject, :recipient_ids, :content,
                                       :sent_at, :preference_type, :file)
  end
end
