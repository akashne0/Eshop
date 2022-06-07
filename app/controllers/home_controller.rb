class HomeController < ApplicationController
  def index
      @banner_image1 = BannerImage.find(1)
      @banner_image2 = BannerImage.find(2)
      @banner_image3 = BannerImage.find(3)
  end
end
