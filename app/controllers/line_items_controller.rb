class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_line_item, only: %i[ edit update destroy]


  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # POST /line_items or /line_items.json
  def create
    if params.include? :wishlist_id
      puts "Inside the wishlist condition"

      product = Product.find(params[:product_id])
      @line_item = @cart.add_product(product.id)
      puts "before delete of product"
      current_user.wishlist.product_id.delete(params[:product_id].to_i)
      puts "After delete of product"
      current_user.wishlist.save
      
      respond_to do |format|
        if @line_item.save
          unless current_user.wishlist.product_id.empty?
          # format.html { redirect_to @line_item.cart}
          format.html { redirect_to wishlist_path(params[:wishlist_id]), notice: "Product added to cart successfully."}
          format.json { render action: 'show', status: :created, location: @line_item }
          else
          format.html { redirect_to root_url, notice: "Product added to cart successfully But Your wishlist is empty!"}
          current_user.wishlist.destroy
          end
        # else
        #   format.html { render :new, status: :unprocessable_entity }
        #   format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
      
    else
      product = Product.find(params[:product_id])
      @line_item = @cart.add_product(product.id)
      # @line_item = LineItem.new(line_item_params)
      
      respond_to do |format|
        if @line_item.save
          # format.html { redirect_to @line_item.cart}
          format.html { redirect_to root_url, notice: "Product added to cart successfully."}
          format.json { render action: 'show', status: :created, location: @line_item }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to line_item_url(@line_item), notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to  @line_item.cart, notice: "Line item was successfully destroyed." }
      # format.html { redirect_to  @line_item.cart, notice: "Line item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
