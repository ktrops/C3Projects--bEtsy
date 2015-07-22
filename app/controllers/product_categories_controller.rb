class ProductCategoriesController < ApplicationController
  after_filter :last_page

  def last_page
    session[:previous_page] = request.referer || :back

  end

  def create
    product_id = params[:product_id].to_i
    category_id = params[:product_category][:category_id].to_i
    @product = Product.find(product_id)
    if category_exists_for_product?(product_id, category_id) == false
      ProductCategory.create(product_category_params)
      
      redirect_to @product
    else
      flash[:errors] = "You cannot assign the same category"
      redirect_to @product
    end
  end

  def destroy
    @product_category = ProductCategory.find(params[:id])
    category_name = @product_category.category.name
    @product_category.destroy

    # checks for if destroy goes wrong
    if @product_category
      flash[:errors] = "Something went wrong."
    else
      flash[:success] = "You have removed the category 'category_name'."
    end
    @product = Product.find(params[:product_id])
    redirect_to @product
  end

  def new_category
    @category = Category.new
  end

  def create_category
    @category = Category.create(category_params)
    if @category.save
      redirect_to session[:previous_page]
    else
      render :new_category
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
