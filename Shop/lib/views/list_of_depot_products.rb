module Shop
  class ListOfDepotProducts
    def print
      puts FetchDepot.new.call.to_s
    end
  end
end
