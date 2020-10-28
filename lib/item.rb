class Item
  attr_reader :name, :price

  def initialize(name: name, price: price)
    @name = name
    @price = price.delete("$").to_f
  end
end
