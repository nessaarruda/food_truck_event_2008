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
    # @stock_qty.each do |item, quantity|
      if @stock_qty[item].nil?
        @stock_qty[item] = 0
      else
        @stock_qty[item] += @inventory[item]
      end
    # end
    binding.pry
  end

  def stock(item, quantity)
    @inventory.each do |item, quantity|
      if @inventory[item].nil?
        @inventory[item] = quantity
      else
        @inventory[item] += quantity
      end
    end
    @inventory
  end
end
