class AddressesController < ApplicationController
  before_action :set_order, only: %i[ show edit update ]
  before_action :authenticate_user!

  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
    respond_to do |format|
      format.js {}
    end
  end

  def show

  end

  def create
    @address = current_user.addresses.create(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to cart_url(@cart), notice: "Address was successfully added. please select address" }
        # format.html { redirect_to root_url, notice: "Cart was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_address
    @address = Address.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def address_params
    params.require(:address).permit(:address_1, :address_2, :city, :state, :country, :zipcode, :user_id )
  end
end

