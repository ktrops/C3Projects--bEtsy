class ProductCategoriesController < ApplicationController
  after_filter :last_page

  def last_page
    session[:previous_page] = request.referer || :back

  end

  def create
    @product = Product.find(params[:product_id])
    ProductCategory.create(product_category_params)
    redirect_to @product
  end

  def destroy
    @product_category = ProductCategory.find(params[:id])
    @product_category.destroy

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
