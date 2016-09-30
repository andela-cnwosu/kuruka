# frozen_string_literal: true
class ContactsController < ApplicationController
  def send_mail
    @contact = Contact.new contact_params
    KurukaMailer.contact_email(@contact).deliver
    render json: { success: true, message: contact_success_message }
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
