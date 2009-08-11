class AdminController < ApplicationController
  before_filter :login_required
  layout "admin"

   def index
      #
      # prepare report
      #
      @users = User.find :all, :order => 'name ASC'
      @products = Product.find :all


      # default is to show current month
      @start_of_report = Time.now.at_beginning_of_month
      @end_of_report = Time.now.at_end_of_month
     
      # prepare a list of previous months
      current_month = Time.now.strftime("%m").to_i
      @previous_months = []
      current_month.downto(1) { |i| @previous_months.push([Date::MONTHNAMES[i], i])}
   
      # check if something else is defined
      # if yes then we want to compute a report
      # for the nth month ago in time
      if params['report']
         @report = Struct.new("Report", :month).new(params['report']['month'].to_i)

         n = current_month - params['report']['month'].to_i

         @start_of_report = Time.now.at_beginning_of_month.months_ago(n)
         @end_of_report = Time.now.at_end_of_month.months_ago(n)
      end
   end
end
