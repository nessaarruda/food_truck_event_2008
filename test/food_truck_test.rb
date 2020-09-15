require "minitest/autorun"
require "minitest/pride"
require './lib/item'
require './lib/food_truck'
require "pry";

# The Event will need to keep track of its FoodTrucks and their Items.
# Each FoodTruck will be able to report its total inventory, stock items,
# and return the quantity of items. Any item not in stock should return 0
# by default.
class FoodTruckTest < Minitest::Test
  # Iteration 1
  def test_it_has_attributes
    food_truck = FoodTruck.new("Rocky Mountain Pies")

    assert_equal "Rocky Mountain Pies", food_truck.name
  end
end
