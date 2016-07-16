module Shop
  class FetchBasketRecord
    def call(product_id)
      FetchBasket.new.call.find(product_id.to_i)
    end
  end
end
