require File.dirname(__FILE__) + '/../test_helper'
require 'payment_controller'

# Re-raise errors caught by the controller.
class PaymentController; def rescue_action(e) raise e end; end

class PaymentControllerTest < Test::Unit::TestCase
  def setup
    @controller = PaymentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
