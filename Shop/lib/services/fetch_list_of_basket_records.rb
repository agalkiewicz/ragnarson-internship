module Shop
  module Services
    class FetchListOfBasketRecords
      def call
        FetchBasket.new.call.list_of_basket_records
      end
    end
  end
end
