class Item
  attr_reader :name,
              :price

  def initialize(info)
    @name = info[:name]
    @price = ('%.2f' % info[:price].delete("$")).to_f
  end
end
