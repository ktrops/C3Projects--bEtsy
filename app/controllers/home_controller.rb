class HomeController < ApplicationController
  def index
    @user = User.find_by(id: session[:user_id])
    @products = Product.front_page_list
  end
end
