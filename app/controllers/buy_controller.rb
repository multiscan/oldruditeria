class BuyController < ApplicationController
  helper :keyboard

  def index
    login
    render :action => 'login'
  end

  def login
    @users = User.find :all, :order => "created_at, name", :conditions => 'expiry IS NULL'
    @screensaver = params[:screensaver]=="save"
  end

  def show_state
    @login_time = (params[:login_time] || Time.now).to_i
    @user = User.find(params[:id])
    @products = Product.find :all, :conditions => 'visible = 1'
    @session_products = Array.new
    @products.each do |prod|
      count = @user.purchase_count(prod.id,Time.at(@login_time),Time.now)
      sp = Hash.new
      sp['name']=prod.name
      sp['quantity']=count
      sp['total']=count*prod.cost
      sp['id']=prod.id
      @session_products.push(sp) unless count==0
    end
  end

  def add_purchase
    @purchase = Purchase.new(:date => Time.now, 
                             :user_id => params['user_id'],
                             :product_id => params['product_id'])
    if @purchase.save
      flash[:notice] = 'Purchase was successfull.'
      redirect_to :action => 'show_state', :id => params['user_id'], :login_time => params['login_time']
    else
      flash[:notice] = 'Purchase was unsuccessfull'
      redirect_to :action => 'show_state', :id => params['user_id'], :login_time => params['login_time']
    end
  end

  def remove_purchase
    number = (params['number'] || 1).to_i
    number.times do
    @purchase = Purchase.find(:first, 
                              :conditions => ((params['product_id'])?
                              ["user_id = ? AND product_id = ?", params['user_id'], params['product_id']]:
                                ["user_id = ?", params['user_id']]),
                              :order => "date DESC")
    @purchase.destroy unless (@purchase==nil)
    end
    redirect_to :action => 'show_state', :id => params['user_id'], :login_time => params['login_time']
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      Notifier::deliver_signup_thanks(@user)
      redirect_to :action => 'index'
    else
      render :action => 'new_user'
    end
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show_state', :id => @user.id
    else
      render :action => 'edit_user'
    end
  end
end
