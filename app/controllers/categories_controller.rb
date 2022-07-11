class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
 
  def show
    @category = nil
    if params.has_key?(:id)
      @category = Category.find(params[:id])
    end
    @products = @category.products.all
  end
end


