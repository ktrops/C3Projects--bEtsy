class ProductsController < ApplicationController

  def index
    @products = Product.all
    @categories = Category.all
    @products_array = []
    @merchant_products = nil
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    @product.save
    redirect_to products_path, method: :get
  end

  def category
    @merchant_products = nil
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

  def merchant
    @products_array = []
    @merchants = User.all
    @merchant = User.find(params[:user])
    @merchant_products = @merchant.products

    render :index
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

private

  def product_params
    params.require(:product).permit(:name, :price, :description, 
                                    :active, :photo_url, :stock, :user_id)
  end

end
