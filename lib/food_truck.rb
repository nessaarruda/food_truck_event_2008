class FoodTruck

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
    @count_items = 0
  end

  def check_stock(item)
    @count_items
  end

  def stock(item,num)
    @inventory[item] = num
    @count_items += num
  end

  def potential_revenue
      total = 0
      inventory.keys.each do |item|
        total += (item.price * inventory[item])
      end
      total
  end
end
