module Shop
  class Info
    def print
      puts "\n\n--------------\n---PRODUCTS---\n--------------"
      ListOfProducts.new.print
      puts "\n\n--------------\n----BASKET----\n--------------"
      ListOfBasketProducts.new.print
      puts "\n\n--------------\n----DEPOT-----\n--------------"
      ListOfDepotProducts.new.print
    end
  end
end
