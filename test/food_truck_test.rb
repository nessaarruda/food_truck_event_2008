require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'

class FoodTruckTest < Minitest::Test

  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  def test_it_exists_and_has_attributes
    assert_equal "Rocky Mountain Pies", @food_truck.name
  end

  def test_inventory_starts_empty
    expected = {}
    assert_equal expected, @food_truck.inventory
  end

  def test_stock_starts_empty
    assert_equal 0, @food_truck.check_stock(@item1)
  end

  def test_it_can_add_to_stock
    @food_truck.stock(@item1, 30)
    expected = {@item1 => 30}
    assert_equal expected, @food_truck.inventory
    assert_equal 30, @food_truck.check_stock(@item1)
    @food_truck.stock(@item1, 25)
    assert_equal 55, @food_truck.check_stock(@item1)
    @food_truck.stock(@item2, 12)
    expected = {@item1 => 25, @item2 => 12}
    assert_equal expected, @food_truck.inventory
  end
end
