class HomeController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    # @front_page_products = Product.front_page
  end
end
