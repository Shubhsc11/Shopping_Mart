class SubcategoriesController < ApplicationController
	before_action :set_subcategory, only: [:show, :edit, :update, :destroy]
  def index
    @subcategories = Subcategory.all
  end

  def show
    @products = @subcategory.products
  end

 	private

    def set_subcategory
      @subcategory = Subcategory.includes(:products).find(params[:id])
    end


    def category_params
      params.require(:category).permit(:subcategory_name, :category_id)
    end
end
