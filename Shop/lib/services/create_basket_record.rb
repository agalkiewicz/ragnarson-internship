module Shop
  module Services
    class CreateBasketRecord
      def call(product_id, amount)
        FetchBasket.new.call
          .add(product_id, amount)
      end
    end
  end
end
