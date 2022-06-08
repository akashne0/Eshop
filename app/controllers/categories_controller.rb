class CategoriesController < ApplicationController
 
  def show
    @category = nil
    if params.has_key?(:id)
      @category = Category.find(params[:id])
    end
    @products = @category.products.all
  end
end


