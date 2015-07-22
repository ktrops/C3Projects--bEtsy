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
      Order.new
    end
  end

  def error_messages(instance)
    error_array = []
    instance.errors.messages.each do |key, value|
      error_array += [[key.to_s.capitalize, value.first]]
    end
    error_array
  end
end
