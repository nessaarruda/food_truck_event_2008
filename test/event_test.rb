require 'minitest/autorun'
require 'minitest/pride'
require './lib/event'
require './lib/food_truck'
require './lib/item'
require 'date'
require 'mocha/minitest'

class EventTest < Minitest::Test

  def setup
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @item5 = Item.new({name: 'Onion Pie', price: '$25.00'})
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @food_truck3.stock(@item1, 65)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Event, @event
    assert_equal "South Pearl Street Farmers Market", @event.name
    expected_date = mock()
    expected_date.stubs(:date).returns("24/02/2020")
  end

  def test_it_can_add_food_trucks
    assert_equal [], @event.food_trucks
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal [@food_truck1, @food_truck2, @food_truck3], @event.food_trucks
  end

  def test_it_can_return_names
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"],@event.food_truck_names
  end

  def test_it_can_list_food_truck_that_sells
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal [@food_truck1, @food_truck3], @event.food_trucks_that_sell(@item1)
    assert_equal [@food_truck2], @event.food_trucks_that_sell(@item4)
  end

  def test_sorted_item_list
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"], @event.sorted_item_list
  end

  def test_total_items
    @food_truck3.stock(@item3, 10)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal 100, @event.total_items(@item1)
  end

  def test_total_inventory
    @food_truck3.stock(@item3, 10)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expected = {
         @item1 => {
           quantity: 100,
           food_trucks: [@food_truck1, @food_truck3]
         },
         @item2 => {
           quantity: 7,
           food_trucks: [@food_truck1]
         },
         @item4 => {
           quantity: 50,
           food_trucks: [@food_truck2]
         },
         @item3 => {
           quantity: 35,
           food_trucks: [@food_truck2, @food_truck3]
         },
       }
       assert_equal expected, @event.total_inventory
  end

  def test_overstock_items
    @food_truck3.stock(@item3, 10)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expected = [@item1]
    assert_equal expected, @event.overstocked_items
    expected = ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"]
    assert_equal expected, @event.sorted_item_list
  end

  def test_is_enough
    @food_truck3.stock(@item3, 10)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal false, @event.is_enough?(@item1, 200)
  end

  def test_sell
    @food_truck3.stock(@item3, 10)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal false, @event.sell(@item1, 200)
    assert_equal false, @event.sell(@item5, 1)
    assert_equal true, @event.sell(@item4, 5)
    assert_equal 45, @food_truck2.check_stock(@item4)
    assert_equal true, @event.sell(@item1, 40)
    assert_equal 0, @food_truck1.check_stock(@item1)
    assert_equal 60, @food_truck3.check_stock(@item1)
  end
end
