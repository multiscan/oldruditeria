class Product < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name
  has_many :costs

  def set_cost #second validate it into sql with setcost
    if costs.nil?
      @costs=Array.new
    end
    @costs << Cost.new(:valid_from => Time.now, 
                       :amount => @cost,
                       :product_id => @id)
    self.save
  end

  def cost=(amount) #first put the cost in @cost
    @cost = amount #todo validate the amount as a float
  end

  def cost
    cost_at_date(Time.now)
  end

  def cost_at_date(date)
    if costs.empty?
      return 0
    else
      current_cost = @costs.first
      for cost in @costs
        if cost.valid_from<=date && cost.valid_from>=current_cost.valid_from
          current_cost = cost
        end
      end
      return current_cost.amount
    end
  end

  def decrease_stock()
    self.stock = self.stock-1
    save
  end
end
