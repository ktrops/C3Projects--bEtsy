class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
  end

  def create
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @order_item = OrderItem.new
    @product_category = ProductCategory.new
    @user = User.find_by(id: session[:user_id])
    # @order = Order.find(cookies[:order_id])
  end

  def toggle_active
    @product = Product.find(params[:id])
    @product.toggle_active!
    redirect_to @product
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
