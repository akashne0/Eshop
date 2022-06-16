class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @products = Product.all.take(6)
    @recommend_products = Product.last(3)
    @banners = BannerImage.all
    @images = ProductImage.all
  end 

  def show
    @product = Product.find(params[:id])
  end


end
