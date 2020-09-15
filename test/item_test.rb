require "minitest/autorun"
require "minitest/pride"
require './lib/item'
require './lib/food_truck'
require "pry";

# The Event will need to keep track of its FoodTrucks and their Items.
# Each FoodTruck will be able to report its total inventory, stock items,
# and return the quantity of items. Any item not in stock should return 0
# by default.
class ItemTest < Minitest::Test
  # Iteration 1
  def test_it_has_attributes
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})

    assert_equal "Apple Pie (Slice)", item2.name
    assert_equal 2.50, item2.price
  end
end
