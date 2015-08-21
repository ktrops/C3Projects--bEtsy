require 'shipping_api'

class ApplicationController < ActionController::Base

  before_action :set_user
  helper_method :current_order

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      new_order = Order.create
      session[:order_id] = new_order.id
      new_order
    end
  end

  def authenticate_user
    if session[:user_id]
       # set current user object to @current_user object variable
      @current_user = User.find(session[:user_id])
      return true
    else
      redirect_to(login_path)
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to user_path(@user.id)
      return false
    else
      return true
    end
  end

  def error_messages(instance)
    error_array = []
    instance.errors.messages.each do |key, value|
      error_array += [[key.to_s.capitalize, value.first]]
    end
    error_array
  end

  private

  def category_exists_for_product?(prod_id, cat_id)
    ProductCategory.find_by(product_id: prod_id, category_id: cat_id) ? true : false
  end

end
