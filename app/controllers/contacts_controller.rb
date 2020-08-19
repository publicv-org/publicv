class ContactsController < ApplicationController
  before_action :find_candidate, only: %i[new create]

  def new
    @contact = Contact.new
  end

  def create
    recaptcha_passed = verify_recaptcha(model: @contact)
    @contact = @user.contacts.build(contact_params)
    if recaptcha_passed && @contact.save
      redirect_to cv_section_path(@user.subdomain)
    else
      if @contact.errors.present? && recaptcha_passed
          flash[:alert] = @contact.errors.full_messages
          redirect_to cv_section_path(@user.subdomain)
      else
        flash[:alert] = "Recaptcha not verified"
        redirect_to cv_section_path(@user.subdomain)
      end
    end
  end

  private

  def find_candidate
    @user = User.find_by(id: contact_params[:user_id])
  end

  def contact_params
    params.require(:contact).permit!
  end
end
