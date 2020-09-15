class FoodTruck
  attr_reader :name,
              :inventory,
              :stock_qty

  def initialize(name)
    @name = name
    @inventory = {}
    @stock_qty = {}
  end

  def check_stock(item)
    stock = 0
    if @stock_qty[item].nil?
      count = 0
    else
      count += item
    end
  end

  def stock(item, quantity)
    @stock_qty.each do |item, quantity|
      if @inventory[item].nil?
        @inventory[item] = quantity
      else
        @inventory[item] += quantity
      end
    end
binding.pry
    @stock_qty
  end
end
