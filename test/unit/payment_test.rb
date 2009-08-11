require File.dirname(__FILE__) + '/../test_helper'

class PaymentTest < Test::Unit::TestCase
  fixtures :payments

  def setup
    @payment = Payment.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Payment,  @payment
  end
end
