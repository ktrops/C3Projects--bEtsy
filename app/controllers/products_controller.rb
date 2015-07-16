class ProductsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    # @order = Order.find(cookies[:order_id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
