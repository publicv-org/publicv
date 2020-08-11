class ContactsController < ApplicationController
  before_action :find_candidate, only: %i[new create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = @user.contacts.build(contact_params)
    if verify_recaptcha(model: @contact) && @contact.save
      debugger
      redirect_to cv_section_path(@user.subdomain)
    else
      render 'contacts/errors'
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
