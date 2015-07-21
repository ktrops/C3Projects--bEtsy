class ProductsController < ApplicationController

  def index
    @products = Product.all
    @categories = Category.all
    @products_array = []
    @merchant_products = nil
  end

  def merchant_index
    @merchant = User.find(params[:user_id])
    @products = @merchant.products
  end

  def new
    @product = Product.new
    @merchant = User.find(params[:user_id])
    @product_id = Product.last.id + 1
    @product_categories = @product.product_categories.build
  end

  def error_messages(instance)
    error_string = ""
    instance.errors.messages.each do |key, value|
      error_string += "#{key.to_s.capitalize} "
      error_string += "#{value.first}. "
    end
    error_string
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      flash[:success] = "You have created a new product"
      redirect_to products_path, method: :get
    else
      flash[:errors] = error_messages(@product)
      redirect_to new_user_product_path
    end
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
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "You successfully updated #{@product.name}."
      redirect_to product_path(@product)
    else
      flash.now[:errors] = "Edit failed, please try again."
      render :edit
    end
  end

  def destroy
  end





  def product_params
    params.require(:product).permit(:name, :price, :description, :active, :photo_url, :stock, :user_id, product_categories_attributes: [:id, :category_id, :product_id])
  end
end
