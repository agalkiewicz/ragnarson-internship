require_relative "./interface"

class Program
  def self.run
    basket = Basket.new
    products = Products.new
    depot = Depot.new(products.products)

    Interface.welcome(products)

    loop do
      Interface.menu
      choice = gets.chomp

      if choice == '1'
        puts "Which product? (Select id.)"
        id = gets.chomp
        product = products.get_product(id.to_i)
        if product.nil?
          puts "Bad id!"
        else
          if depot.is_available?(product)
            basket.add(product)
          else
            puts "PRODUCT IS UNAVAILABLE."
          end
        end

        Interface.display_info(basket, depot)

      elsif choice == '2'
        puts "Which product? (Select id.)"
        id = gets.chomp
        if basket.delete(id.to_i)
          puts "Product deleted from the basket.\n"
          depot.add_product(id.to_i)
        else
          puts "There is no product of this id in the basket."
        end

        Interface.display_info(basket, depot)

      elsif choice == '3'
        exit
      end
    end
  end
end

Program.run
