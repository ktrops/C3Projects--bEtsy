class ProductCategoriesController < ApplicationController
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
  end

  private

  def product_category_params
    { product_id: params[:product_id], 
      category_id: params[:product_category][:category_id] }
  end
end
