Dir["./lib/**/*.rb"].each { |file| require file }

module Shop
  PRODUCTS = Products.new
  DEPOT = Depot.new
  BASKET = Basket.new

  class Main
    def self.run
      Welcome.new.print
      CreateDepot.new.call

      loop do
        begin
          Menu.new.print
          choice = gets.chomp

          case choice
          when '1'
            puts "Which product? (Select id.)"
            id = gets.chomp
            AddProductToBasket.new.call(id.to_i)
            Info.new.print
          when '2'
            puts "Which product? (Select id.)"
            id = gets.chomp
            DeleteProductFromBasket.new.call(id.to_i)
            Info.new.print
          when '3'
            exit
          else
            puts "Invalid option! Choose again."
          end
        rescue Depot::NoProductException
          puts "There is no product of this id in a depot."
          retry
        rescue Basket::NoProductFoundException
          puts "There is no product of this id in the basket."
          retry
        end
      end
    end
  end
end

Shop::Main.run
