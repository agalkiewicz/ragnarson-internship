require_relative "./shop"

class Depot
  attr_accessor :depot

  def initialize(shop)
    @depot = []
    shop.each { |product| add(rand(10), product) }
  end

  def is_available?(product)
    record = @depot.find { |record| record[:product] == product }
    delete_product(record)
  end

  def delete_product(record)
    if record[:quantity] == 0
      false
    else
      record[:quantity] -= 1
      true
    end
  end

  def add_product(id)
    record = @depot.find { |record| record[:product].id == id }
    record[:quantity] += 1
  end

  def to_s
    string = "Id".ljust(4) + "Name".ljust(10) + "Price".ljust(10) + "VAT".ljust(11) +
             "Quantity".ljust(5) + "\n"
    @depot.inject(string) { |string, record| string + "#{record[:product]} #{record[:quantity]}\n" }
  end

  private
  def add(quantity, product)
    @depot << { product: product, quantity: quantity }
  end
end
