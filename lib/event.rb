class Event
  attr_reader :name,
              :food_trucks,
              :date

  def initialize(name)
    @name = name
    @food_trucks = []
    @date = Date.today
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck if !@food_trucks.include?(food_truck)
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
        food_truck.name
      end
  end

  def food_trucks_that_sell(item)
    @food_trucks.map do |food_truck|
      if food_truck.inventory.include?(item)
        food_truck
      end
    end.compact!
  end

  def sorted_item_list
    sorted = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.keys.each do |item|
        sorted << item.name
      end
    end
    sorted.uniq.sort!
  end

  def total_items(item_provided)
    total = 0
    @food_trucks.each do |food_truck|
      food_truck.inventory.each_pair do |item, quantity|
        if item_provided == item
          total += quantity
        end
      end
    end
    total
  end

  def total_inventory
    final_result = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.keys.each do |item|
      second_hash = {}
      second_hash[:food_trucks] = food_trucks_that_sell(item)
      second_hash[:quantity] = total_items(item)
      final_result[item] = second_hash
      end
    end
      final_result
  end

  def overstocked_items
    overstocked = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.keys.each do |item|
        if food_trucks_that_sell(item).count >= 2 && total_items(item) > 50
          overstocked << item
        end
      end
    end
    overstocked.uniq
  end

  def is_enough?(item, quantity_provided)
    quantity = total_items(item)
    quantity >= quantity_provided
  end

  def sell(item, quantity_provided)
    if !is_enough?(item, quantity_provided)
      false
    else
      quantity = quantity_provided
      @food_trucks.each do |food_truck|
        while food_truck.inventory[item] > 0 && quantity > 0
          food_truck.inventory[item] -= 1
          quantity -= 1
        end
      end
      true
    end
  end
end
