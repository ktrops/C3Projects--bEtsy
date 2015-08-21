class ProductsController < ApplicationController
  before_action :authenticate_user, except: [:merchant, :index, :show, :category]

  def index
    @products = Product.all
    @categories = Category.all
    @products_array = []
    @merchant_products = nil
  end

  def merchant_index
    @merchant = @current_user
    @products = @merchant.products
  end

  def new
    @product = Product.new
    # @merchant = User.find(params[:user_id])
    @merchant = @current_user
    @product_id = Product.last.id + 1
    @product_categories = @product.product_categories.build
  end

  def create
    @product = Product.new(product_params)
    @product.price = unformat_price(params[:product][:price])
    if @product.save
      flash[:successfull] = "You have created a new product"

      redirect_to products_merchant_index_path(params[:user_id]), method: :get
    else
      flash[:failed] = error_messages(@product)

      redirect_to new_user_product_path
    end
  end

  def category
    @merchant_products = nil
    @categories = Category.all
    if params[:category].empty?
      redirect_to products_path
    else
      @category = Category.find(params[:category])
      pro = @category.product_categories
      product_id_array = []
      pro.each do |item|
        product_id_array << item.product_id
      end
      @products_array = []
      product_id_array.each do |id|
        @products_array << Product.find(id)
      end

      render :index
    end

  end

  def merchant
    @products_array = []
    @merchants = User.all
    if params[:user].empty?
      redirect_to products_path
    else
      @merchant = User.find(params[:user])
      @merchant_products = @merchant.products

      render :index
    end

  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @order_item = OrderItem.new
    @product_category = ProductCategory.new
    @user = User.find_by(id: session[:user_id])
  end

  def toggle_active
    product = Product.find(params[:id])
    product.toggle_active!

    redirect_to :back
  end

  def edit
    @product = Product.find(params[:id])
    @product_category = ProductCategory.new
    if @product.user_id != @current_user.id
      redirect_to user_products_path(@current_user.id)
    end
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    @product.price = unformat_price(params[:product][:price])
    if @product.save
      flash[:success] = "You successfully updated #{@product.name}."

      redirect_to product_path(@product)
    else
      flash.now[:errors] = "Edit failed, please try again."

      render :edit
    end
  end

  private

  def unformat_price(price)
    price.delete("$").delete(",").to_f*100
  end

  def product_params
    params.require(:product).permit(
      :name, :price, :description, :active, :photo_url, :stock, :user_id, :length, :width, :height, :weight,
        product_categories_attributes: [
          :id, :category_id, :product_id
        ]
      )
  end
end
