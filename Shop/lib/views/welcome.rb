module Shop
  class Welcome
    def print
      puts "Welcome to our shop.\n\n--------------\n---PRODUCTS---\n--------------\n"
      ListOfProducts.new.print
    end
  end
end
