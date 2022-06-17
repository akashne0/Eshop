class ContactUsController < ApplicationController

  def index
    @contact_us = ContactUs.all
  end

  def new
    @contact = ContactUs.new
  end

  def create
    @contact = ContactUs.new(contact_us_params)

  end

  private

  def contact_us_params
    params.require(:contact_us).permit(:name, :email, :contact_no, :message)
  end

end
