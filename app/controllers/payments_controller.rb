class PaymentsController < ApplicationController
  before_filter :login_required
  layout "admin"

  def index
    list
    render :action => 'list'
  end

  def list
    @payments = Payment.paginate :page => params[:page], :order => 'date DESC', :per_page => 50
    # @payment_pages, @payments = paginate :payment, :order => "date DESC", :per_page => 20
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(params[:payment])
    if @payment.save
      flash[:notice] = 'Payment was successfully created.'
      redirect_to :controller => 'admin', :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    @payment = Payment.find(params[:id])
    if @payment.update_attributes(params[:payment])
      flash[:notice] = 'Payment was successfully updated.'
      redirect_to :action => 'show', :id => @payment
    else
      render :action => 'edit'
    end
  end

  def destroy
    Payment.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
