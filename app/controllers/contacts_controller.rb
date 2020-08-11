class ContactsController < ApplicationController
  before_action :find_candidate, only: %i[new create]

  def new
    @contact = Contact.new
  end

  def create
    recaptcha_passed = verify_recaptcha(model: @contact,
                                        action: 'contact_create',
                                        minimum_score: ENV['RECAPTCHA_MINIMUM_SCORE'].to_f)
    @contact = @user.contacts.build(contact_params)
    if recaptcha_passed && @contact.save
      redirect_to cv_section_path(@user.subdomain)
    else
      # TODO: show recaptcha challenge unless recaptcha_passed see #69
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
