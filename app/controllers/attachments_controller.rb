class AttachmentsController < ApplicationController
  def create
    attachment = Attachment.create(attachment_params)
    render json: { attachment_id: attachment.id, url: rails_blob_path(attachment.file) }
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
