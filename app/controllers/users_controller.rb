class UsersController < ApplicationController
  before_filter :login_required

  layout "admin"

  def index
    list
    render :action => 'list'
  end

  def list
    # @user_pages, @users = paginate :user, :per_page => 20, :order => 'name ASC'
    @users = User.paginate :page => params[:page], :order => 'name ASC', :per_page => 20
    
  end

  def show
    @user = User.find(params[:id])
  end
  
  def report
#    @users = User.find :all, :order => 'name ASC'
    @users = User.current_users
    @products = Product.find :all
		@end_of_report = Time.now.at_beginning_of_month
		@start_of_report = Time.now.at_beginning_of_month.last_month
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
			Notifier::deliver_signup_thanks(@user)
			flash[:notice] = 'Mail sent'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
		@user.update_attribute('expiry', Time.now)
    redirect_to :action => 'list'
  end
	
	def restore
	  @user = User.find(params[:id])
		@user.update_attribute('expiry', nil)
		redirect_to :action => 'list'
	end
	
  def send_personal_report
    report

    for user in User.current_users
      if user.balance < 5
        begin
          Notifier::deliver_personal_report(user)
        rescue
        end
      end
    end

    flash[:notice] = 'Mails sent to the users'
    redirect_to :controller => "admin", :action => 'index'
  end
end
