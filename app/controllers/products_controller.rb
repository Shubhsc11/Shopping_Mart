# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: %i[show edit update destroy]

  def index
    @categories = Category.includes(:products).all
    @products = Product.order(created_at: :asc)
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit
    @categories = Category.all.map { |c| [c.category_name, c.id] }
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to @product
    else
      redirect_to new_product_path
    end
  end

  def update
    @product.category_id = params[:category_id]

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:p_name, :p_price, :p_qty, :category_id, :subcategory_id, :user_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def set_category
    @category = Category.includes(:products).find(params[:id])
  end
end
