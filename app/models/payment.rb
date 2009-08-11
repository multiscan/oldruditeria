class Payment < ActiveRecord::Base
  belongs_to :user
  validates_associated :user
  validates_numericality_of :amount
end
