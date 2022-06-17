class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, notice: "Your Query added Successfully!"}
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :contact_no, :message)
  end

end
