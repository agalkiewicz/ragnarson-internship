module Shop
  class Products
    attr_reader :list_of_products

    def initialize
      @list_of_products = [
        Product.new(name: "Book",  price: 24.50, vat: 0.05),
        Product.new(name: "Pot",   price: 12.70, vat: 0.08),
        Product.new(name: "Bowl",  price: 2.00,  vat: 0.08),
        Product.new(name: "Knife", price: 10.15, vat: 0.08),
        Product.new(name: "Movie", price: 27.50, vat: 0.05)
      ]
    end

    def find(product_id)
      list_of_products.find { |product| product.id == product_id }
    end

    def to_s
      "Id".ljust(4) +
      "Name".ljust(10) +
      "Price".ljust(10) +
      "VAT".ljust(6) + "\n" +
      list_of_products.map(&:to_s).join("\n")
    end
  end
end
