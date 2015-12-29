class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
    
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
      @products = Product.paginate(:page => params[:page], :per_page => 8)
  end

  def purchase
  end

  def show
      @product = Product.find(params[:id])
  end

  def edit 
      @product = Product.find(params[:id])
  end

  def charge
      @product = Product.find(params[:id])
      token = params[:stripeToken]
      begin 
        charge = Stripe::Charge.create(
            amount: (@product.price * 100).to_i,
            currency: "usd",
            source: token,
            description: @product.title
            )
        rescue Stripe::CardError => e
           flash[:red] = "error"
           redirect_to products_path
        end
      flash[:green] = "Charge successfull!"
      redirect_to root_url
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
