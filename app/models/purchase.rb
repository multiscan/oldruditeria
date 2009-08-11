class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  validates_associated :user
  validates_associated :product

  def update_value()
      v = product.cost_at_date(date);
      update_attributes(:value => v);
  end

  def before_create()
    prod=Product.find(self.product_id)
    self.value = prod.cost_at_date(self.date)
  end

  def after_create()
    prod=Product.find(self.product_id)
    prod.decrease_stock;
  end
  
end
