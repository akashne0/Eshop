class AddressController < ApplicationController
  before_action :set_order, only: %i[ show edit update ]

  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
  end

  def show

  end

  def create
    @address = Address.new(address_params)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:address_1, :address_2, :city, :state, :country, :zipcode )
  end
end

