class HomeController < ApplicationController
  def index
      @products = Product.all.take(15)
  end
end
