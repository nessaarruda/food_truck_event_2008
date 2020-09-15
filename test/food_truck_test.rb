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

  def test_it_can_add_inventory
    food_truck = FoodTruck.new("Rocky Mountain Pies")
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})

    expected = {}
    expected_1 = {item1 => 30}
    expected_2 = {item1 => 55, item2 => 12}

    assert_equal expected, food_truck.inventory

    assert_equal 0, food_truck.check_stock(item1)

    food_truck.stock(item1, 30)

    assert_equal expected_1, food_truck.inventory

    assert_equal 30, food_truck.check_stock(item1)

    food_truck.stock(item1, 25)

    assert_equal 55, food_truck.check_stock(item1)

    food_truck.stock(item2, 12)

    assert_equal expected_1, food_truck.inventory
  end
end
