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
            # require "pry"; binding.pry
            if item_provided == item
            total += food_truck.inventory[item]
          end
        end
      end
      total
  end

  def total_inventory
  total_items = {}
  hash = {}
  @food_trucks.each do |food_truck|
        food_truck.inventory.keys.each do |item|
          if hash[:food_trucks]
            require "pry"; binding.pry
            hash[:food_trucks] << food_trucks_that_sell(item)
            hash[:quantity] = item_count(item)
          else
          hash[:quantity] = item_count(item)
          hash[:food_trucks] = food_trucks_that_sell(item)
        end
          total_items[item] = hash

        end
      end
        total_items
  end

end
