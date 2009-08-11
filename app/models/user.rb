require 'soap/wsdlDriver'

class User < ActiveRecord::Base
  @@default_pic_url = "http://people.epfl.ch/images/noprofile.jpg"
  @@webservice_location = "http://people.epfl.ch/wsdl/PeopleWS.wsdl"

  validates_presence_of :name, :email
  has_many :purchases
  has_many :payments
	
  def before_create
    self.update_picture
  end

  def get_picture #todo change this
    if (self.picture=="")
      return @@default_pic_url
    else
      return self.picture
    end
  end

  def update_picture
    #todo what happens with bad sciper numbers? nothing... weird
    begin
      server=SOAP::WSDLDriverFactory.new(@@webservice_location)
      driver=server.create_rpc_driver 
      self.picture=driver.wSgetProfiles(:ScipersList => String(self.camipro)).s_gensym3.photourl
      return true #check that we actually got something worthwhile
    rescue
      return true
    end
  end
  
  def balance
    totalpayed, resto = Payment.find_by_sql("select sum(amount) as sum from payments where user_id = #{self.id}")
    totalbought, resto = Purchase.find_by_sql("select sum(value) as sum from purchases where user_id = #{self.id}")
    totalpayed.sum.to_f - totalbought.sum.to_f
  end

  def balance_old
    totalpayed = if self.payments.empty? 
                   0 
                 else
                   total=0 
                   self.payments.each {|payment| total += payment.amount}
                   total
                 end
    totalbought = if self.purchases.empty? 
                    0 
                  else
                    total=0 
                    self.purchases.each {
        |purchase| 
#        total = total+purchase.product.cost_at_date(purchase.date)
        total = total+purchase.value
      }
                    total
                  end
    return totalpayed - totalbought
  end
  
	def self.current_users
		User.find :all, :order => "name", :conditions => ['expiry IS NULL']
	end
	
	def self.destroyed_users
		User.find :all, :order => "name", :conditions => ['expiry IS NOT NULL']
	end
	
  # Count the number of purchases for a given product and a given time range
  def purchase_count(product, start_of_report, end_of_report)
   # self.purchases.count ["product_id = ? AND date >= ? AND date <= ?" , product, start_of_report, end_of_report]
	 self.purchases.count :conditions => ["product_id = ? AND date >= ? AND date <= ?" , product, start_of_report, end_of_report]
  end
end
