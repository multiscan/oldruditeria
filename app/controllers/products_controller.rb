class ProductsController < ApplicationController
  before_filter :login_required

  layout "admin"

  def index
    list
    render :action => 'list'
  end

  def list
    # @product_pages, @products = paginate :product, :per_page => 20
    @products = Product.paginate :page => params[:page], :per_page => 20
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      @product.set_cost
      flash[:notice] = 'Product was successfully created.'
      redirect_to :action => 'list'
    else
      redirect_to :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      @product.set_cost
      flash[:notice] = 'Product was successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
	  @product = Product.find(params[:id])
		@product.update_attribute('visible', 0)
    redirect_to :action => 'list'
  end
	
	def restore
	  @product = Product.find(params[:id])
		@product.update_attribute('visible', 1)
		redirect_to :action => 'list'
	end
	
end
