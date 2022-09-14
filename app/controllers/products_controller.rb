class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :asc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save  
      redirect_to @product
    else
      redirect_to new_product_path
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all.map{|c| [ c.category_name, c.id ] }
  end

  def update
    @product = Product.find(params[:id])
    @product.category_id = params[:category_id]

    if @product.update(product_params)
    	flash[:alert] = "Updates Successfully!!!"
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
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
end
