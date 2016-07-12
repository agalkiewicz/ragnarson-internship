module Shop
  class ListOfProducts
    def print
      puts FetchProducts.new.call.to_s
    end
  end
end
