# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  def index
    @categories = Category.all
  end

  def show; end

  private

  def set_category
    @category = Category.includes(subcategories: :products).find(params[:id])
  end

  def category_params
    params.require(:category).permit(:category_name)
  end
end
