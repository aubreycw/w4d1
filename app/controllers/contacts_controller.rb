class ContactsController < ApplicationController

  def index
    user = User.find(params[:user_id])
    contacts = user.contacts
    contacts += user.shared_contacts
    render json: contacts
  end

  def show
    begin
      contact = Contact.find(params[:id])
      render json: contact
    rescue ActiveRecord::RecordNotFound
      render text: "Could not find id"
    end
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    if Contact.update(params[:id], contact_params)
      render json: Contact.find(params[:id])
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    if Contact.exists?(params[:id])
      Contact.delete(params[:id])
      render json: Contact.all
    else
      render text: "could not delete"
    end
  end

  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end

end
