class ProductsController < ApplicationController

  def index
    @products = Product.all
    @categories = Category.all
    @products_array = []
  end

  def new
  end

  def category
    @categories = Category.all
    @category = Category.find(params[:category])
    pro = @category.product_categories
    product_id_array = []
    pro.each do |item|
      product_id_array << item.product_id
    end
    @products_array = []
    products = product_id_array.each do |id|
      @products_array << Product.find(id)
    end

    render :index
  end

  def create
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @order_item = OrderItem.new
    @product_category = ProductCategory.new
    @user = User.find_by(id: session[:user_id])
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
