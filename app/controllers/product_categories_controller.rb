class ProductCategoriesController < ApplicationController
  after_filter :last_page

  def last_page
    session[:previous_page] = request.referer || :back
  end

  def create
    product_id = params[:product_id]
    category_id = params[:product_category][:category_id]
    @product = Product.find(product_id)
    unless category_exists_for_product?(product_id, category_id)
      ProductCategory.create(product_category_params)
      redirect_to @product
    else
      flash[:errors] = "You cannot assign the same category"
      redirect_to @product
    end
  end

  def destroy
    product_category = ProductCategory.find_by(id: params[:id])
    if product_category
      category_name = product_category.category.name
      product_category.destroy
    end
    # checks for if destroy goes wrong
    product_category2 = ProductCategory.find_by(id: params[:id])
    if product_category2
      flash[:errors] = "Something went wrong."
    else
      flash[:success] = "You have removed the category '#{category_name}'."
    end
    
    redirect_to :back
  end

  def new_category
    @category = Category.new
  end

  def create_category
    @category = Category.create(category_params)
    if @category.save
      flash[:success] = "You have created a new category"
      if session[:previous_page] == request.url
        redirect_to products_merchant_index_path(session[:user_id])
      else
        redirect_to session[:previous_page] 
      end
    else
      flash[:errors] = error_messages(@category)
      redirect_to new_category_path
    end
  end

  private

  def product_category_params
    { product_id: params[:product_id],
      category_id: params[:product_category][:category_id] }
  end

  def category_params
    params.require(:category).permit(:id, :name)
  end
end
