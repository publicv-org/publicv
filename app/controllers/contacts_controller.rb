class ContactsController < ApplicationController
  before_action :find_candidate, only: %i[new create]

  def new
    @contact = Contact.new
  end

  def create
    recaptcha_passed = verify_recaptcha(model: @contact)
    @contact = @user.contacts.build(contact_params)
    unless recaptcha_passed && @contact.save
      flash[:alert] = @contact.errors.present? ? @contact.errors.full_messages.join(', ') : t('content.main.recaptcha.failure')
    end
    redirect_to cv_section_path(@user.subdomain)
  end

  private

  def find_candidate
    @user = User.find_by(id: contact_params[:user_id])
  end

  def contact_params
    params.require(:contact).permit!
  end
end
