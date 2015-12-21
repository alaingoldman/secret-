class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
        flash[:green] = "Success"
        redirect_to product_path(@product)
    else
        flash[:red] = @product.errors.full_messages.first
        render "new"
    end
  end
  
  def index
      @products = Product.all
  end

  def show
      @product = Product.find(params[:id])
  end

  def edit 
      @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
        flash[:green] = "edit made"
        redirect_to product_path(@product)
    else
        flash[:red] = @product.errors.full_messages.first
        render "edit"
    end
  end
  
  private 
    def product_params
        params.require(:product).permit(:title, :category, :description, :price, :image)
    end
end
