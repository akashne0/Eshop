class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
      @products = Product.all.take(15)
  end
end
