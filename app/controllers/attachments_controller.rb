class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.save
    render json: { attachment_id: @attachment.id }
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :newsletter_id)
  end
end
