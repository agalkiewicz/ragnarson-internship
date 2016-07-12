module Shop
  class CreateBasketRecord
    def call(product_id)
      FetchBasket.new.call.add(product_id)
    end
  end
end
