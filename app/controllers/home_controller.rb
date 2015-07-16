class HomeController < ApplicationController
  def index
    @products = Product.front_page_list
  end
end
