class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.new(attachment_params)
    @attachment.save
    render json: { attachment_id: @attachment.id, url: rails_blob_path(@attachment.file) }
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
