module Shop
  module Models
    class Basket
      attr_accessor :list_of_basket_records

      def initialize
        @list_of_basket_records = []
      end

      def add(product_id, amount)
        list_of_basket_records << BasketRecord.new(product_id, amount)
      end

      def delete(product_id)
        basket_record = Services::FetchBasketRecord.new.call(product_id)
        list_of_basket_records.delete(basket_record)
      end

      def find(product_id)
        list_of_basket_records.find { |record| record.product_id == product_id }
      end

      def sum_brutto
        list_of_basket_records.map(&:sum_brutto).reduce(0, :+)
      end
    end
  end
end
