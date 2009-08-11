class Cost < ActiveRecord::Base
  belongs_to :product
  validates_associated :product
  validates_presence_of :amount
  validates_presence_of :valid_from
end
