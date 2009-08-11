require File.dirname(__FILE__) + '/../test_helper'

class PurchaseTest < Test::Unit::TestCase
  fixtures :purchases

  def setup
    @purchase = Purchase.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Purchase,  @purchase
  end
end
