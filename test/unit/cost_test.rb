require File.dirname(__FILE__) + '/../test_helper'

class CostTest < Test::Unit::TestCase
  fixtures :costs

  def setup
    @cost = Cost.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Cost,  @cost
  end
end
