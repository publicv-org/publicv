module Admins
  class NewslettersController < ApplicationController
    before_action :set_newsletter, except: %i[index create]
    before_action :authenticate_user!
    before_action :authenticate_admin

    def index
      @newsletters = Newsletter.order(:created_at)
    end

    def new; end

    def create
      @newsletter = Newsletter.new(newsletter_params)
      if @newsletter.save
        link_attachments
        flash[:success] = I18n.t('flash.create', resource_name: @newsletter)
        redirect_to admins_newsletters_path
      else
        render :new
      end
    end

    def edit; end

    def update
      link_attachments
      if @newsletter.update(newsletter_params)
        flash[:success] = I18n.t('flash.update', resource_name: @newsletter)
        redirect_to admins_newsletters_path
      else
        render :edit
      end
    end

    private

    def set_newsletter
      @newsletter = Newsletter.find_by(id: params[:id])
      @newsletter ||= Newsletter.new
    end

    def authenticate_admin
      authorize :newsletter
    end

    def link_attachments
      params[:newsletter][:attachments]&.each do |_index, attachment_id|
        attachment = Attachment.find_by(id: attachment_id.keys)
        attachment.update(resource: @newsletter)
      end
    end

    def newsletter_params
      params.require(:newsletter).permit(:name, :subject, :recipient_ids, :content,
                                         :sent_at, :preference_type)
    end
  end
end
