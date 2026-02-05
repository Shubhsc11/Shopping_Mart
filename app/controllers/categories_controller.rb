class CategoriesController < ApplicationController

	before_action :set_category, only: [:show, :edit, :update, :destroy]
  def index
    @categories = Category.all
  end

  def show
    @products = @category.products
     # @images  = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg"]
     # @random_no = rand(5)
     # @random_image = @images[@random_no]
  end

 	private

    def set_category
      @category = Category.includes(:products).find(params[:id])
    end


    def category_params
      params.require(:category).permit(:category_name)
    end
	
end
