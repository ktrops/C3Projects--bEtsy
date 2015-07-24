class ReviewsController < ApplicationController

  before_action :stars_to_rating, only: :create

  def new
    @review = Review.new
    @product = Product.find(params[:product_id])
    if @product.user == @user
      flash[:errors] = "You cannot leave a review for your own product."

      redirect_to @product
    else
      render :new
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.create(review_params)
    if @review.save
      redirect_to product_path(params[:product_id])
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :review_text, :product_id)
  end

  def stars_to_rating
    case params[:review][:rating]
    when "★☆☆☆☆"
      params[:review][:rating] = 1
    when "★★☆☆☆"
      params[:review][:rating] = 2
    when "★★★☆☆"
      params[:review][:rating] = 3
    when "★★★★☆"
      params[:review][:rating] = 4
    when "★★★★★"
      params[:review][:rating] = 5
    end
  end
end
