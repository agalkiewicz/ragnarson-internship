require_relative "./basket"
require_relative "./depot"

class Interface
  def self.welcome(shop)
    puts "Welcome to our shop.\n\n--------------\n---PRODUCTS---\n--------------\n" +
         "Id".ljust(4) + "Name".ljust(10) + "Price".ljust(10) + "VAT".ljust(6) + "\n" +
         shop.to_s
  end

  def self.menu
    puts "\n\nChoose option:\n\t1 - add item to your basket\n\t2 - delete item from the basket\n" +
         "\t3 - pay and go\n"
  end

  def self.display_info(basket, depot)
    puts "\n\n--------------\n----BASKET----\n--------------"
    puts "#{basket}"
    puts "\n\n--------------\n----DEPOT-----\n--------------"
    puts "#{depot}"
  end
end
