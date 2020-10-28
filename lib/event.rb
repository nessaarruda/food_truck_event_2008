class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item_provided)
    food_trucks_that_sell = []
    @food_trucks.each do |food_truck|
          if food_truck.inventory.include?(item_provided)
            food_trucks_that_sell << food_truck
          end
        end
          food_trucks_that_sell

  end

  def sorted_item_list
    array = []
    @food_trucks.each do |food_truck|
          food_truck.inventory.keys.each do |item|
          array << item.name
        end
      end
      array.sort.uniq
  end

  def item_count(item_provided)
    total = 0
    @food_trucks.each do |food_truck|
          food_truck.inventory.keys.each do |item|
            if item_provided == item
            total += food_truck.inventory[item]
          end
        end
      end
      total
  end

  def second_hash(item)
    second_hash = {}
    @food_trucks.each do |food_truck|
      second_hash[:quantity] = item_count(item)
      second_hash[:food_trucks] = food_trucks_that_sell(item)
    end
    second_hash
  end

  def total_inventory
    first_hash = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.keys.each do |item|
        first_hash[item] = second_hash(item)
      end
    end
    first_hash
  end

  def overstocked_items
    # An item is overstocked if it is sold by more than 1
    # food truck AND the total quantity is greater than 50.
    item_array = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.keys.each do |item|
        if food_trucks_that_sell(item).length >= 2 && item_count(item) > 50
          item_array << item
        end
      end
    end
    item_array.uniq
  end
end
