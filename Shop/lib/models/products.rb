module Shop
  class Products
    attr_reader :list_of_products

    NoProductFoundException = Class.new(StandardError)

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
      found_product = list_of_products.find { |product| product.id == product_id }
      if found_product
        found_product
      else
        raise NoProductFoundException
      end
    end
  end
end
