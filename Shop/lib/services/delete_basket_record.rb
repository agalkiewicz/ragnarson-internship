module Shop
  class DeleteBasketRecord
    def call(product_id)
      FetchBasket.new.call.delete(product_id)
    end
  end
end
