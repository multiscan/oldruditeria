class PurchasesController < ApplicationController
  before_filter :login_required

  layout "admin"

  def index
    list
    render :action => 'list'
  end

  def list
    # @purchase_pages, @purchases = paginate :purchase, :order => "date DESC", :per_page => 20
    @purchases = Purchase.paginate :page => params[:page], :order => 'date DESC', :per_page => 20
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def new
    # @purchase = Purchase.new
    @products = Product.find(:all)
    @user = User.find(params['user_id'])
    totalpayed = if @user.payments.empty? 
                   0 
                 else
                   total=0 
                   @user.payments.each {|payment| total = total+payment.amount}
                   total
                 end
    totalbought = if @user.purchases.empty? 
                    0 
                  else
                    total=0 
                    @user.purchases.each {
        |purchase| 
        total = total+purchase.product.cost_at_date(purchase.date)
      }
                    total
                 end
    @balance = ((totalpayed - totalbought)*100).to_i/100.0
  end

  def create
    @purchase = Purchase.new(:date => Time.now, 
                             :user_id => params['user_id'],
                             :product_id => params['product_id'])
    if @purchase.save
      flash[:notice] = 'Purchase was successfull.'
      redirect_to :action => 'new', :user_id => params['user_id']
    else
      redirect_to :action => 'new', :user_id => params['user_id']
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])
  end

  def update
    @purchase = Purchase.find(params[:id])
    if @purchase.update_attributes(params[:purchase])
      flash[:notice] = 'Purchase was successfully updated.'
      redirect_to :action => 'show', :id => @purchase
    else
      render :action => 'edit'
    end
  end

  def destroy
    Purchase.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
