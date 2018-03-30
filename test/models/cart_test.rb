require 'test_helper'

class CartTest < ActiveSupport::TestCase

  test "cart should create a new line item when adding a new proudct" do
    cart = carts(:only_ruby)

    cart.add_product(products(:two))

    assert_equal cart.line_items.size, 2
  end

  test "cart should update existing line item quantity when adding an existing product" do
    cart = carts(:only_ruby)

    cart.add_product(products(:ruby))

    assert_equal cart.line_items.size, 1
  end
end
