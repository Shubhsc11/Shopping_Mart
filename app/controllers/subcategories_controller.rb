# frozen_string_literal: true

class SubcategoriesController < ApplicationController
  before_action :set_subcategory, only: :show

  def index
    @subcategories = Subcategory.all
    respond_to do |format|
      format.html
      format.json { render json: @subcategories }
    end
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
