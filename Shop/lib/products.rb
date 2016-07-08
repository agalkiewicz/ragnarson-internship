require_relative "./product"

class Products
  attr_accessor :products

  def initialize
    @products = [
      Product.new(name: "Book", price: 24.50, vat: 0.05),
      Product.new(name: "Pot", price: 12.70, vat: 0.08),
      Product.new(name: "Bowl", price: 2.00, vat: 0.08),
      Product.new(name: "Knife", price: 10.15, vat: 0.08),
      Product.new(name: "Movie", price: 27.50, vat: 0.05)
    ]
  end

  def get_product(id)
    @products.find { |product| product.id == id }
  end

  def to_s
    @products.inject("") { |string, product| string + "#{product}\n" }
  end
end
