class WishlistsController < ApplicationController
  include CurrentCart
  before_action :set_wishlist, only: %i[ show edit update destroy ]

  # GET /wishlists or /wishlists.json
  def index
    @wishlists = Wishlist.all
  end

  # GET /wishlists/1 or /wishlists/1.json
  def show
    @wishlist = current_user.wishlist
    product_ids = @wishlist.product_id
    @products = Product.where(id: product_ids)
  end

  # GET /wishlists/new
  def new
    @wishlist = Wishlist.new
  end

  # GET /wishlists/1/edit
  def edit
  end

  # POST /wishlists or /wishlists.json
  def create
    # byebug
    @message = ""
    if current_user
      if current_user.wishlist == nil
        @wishlist = current_user.build_wishlist(wishlist_params)
        @wishlist.product_id << params[:product_id]
        puts "New wishlist"

        @wishlist.save
        @message = "Wishlist created and Product added to wishlist!" 
        
      else 
        @wishlist = current_user.wishlist
        if @wishlist.product_id.include? params[:product_id].to_i
          puts "already added to wishlist"
          @message = "Product already present in wishlist!"

        else
          puts "adding to wishlist"
          @wishlist.product_id << params[:product_id]
          @wishlist.save

          @message = "Product is added to wishlist!"  
        end
      end
    else
      @message = "Please login to add your wishlist!"
    end
    puts @message
    respond_to do |format|
      format.js 
    end
  end

  

  

  

  # PATCH/PUT /wishlists/1 or /wishlists/1.json
  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to wishlist_url(@wishlist), notice: "Wishlist was successfully updated." }
        format.json { render :show, status: :ok, location: @wishlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1 or /wishlists/1.json
  def destroy
    @wishlist.destroy

    respond_to do |format|
      format.html { redirect_to wishlists_url, notice: "Wishlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      if params.include? :id
        #add execption here as no id found
        @wishlist = Wishlist.find(params[:id])
      else 
        redirect_to root_url, flash[:alert] = "Currently this user does not have any wishlist created!"
      end
    end

    # Only allow a list of trusted parameters through.
    def wishlist_params
      params.fetch(:wishlist, {})
    end
end
