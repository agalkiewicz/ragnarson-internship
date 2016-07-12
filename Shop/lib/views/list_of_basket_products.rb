module Shop
  class ListOfBasketProducts
    def print
      puts FetchBasket.new.call.to_s
    end
  end
end
