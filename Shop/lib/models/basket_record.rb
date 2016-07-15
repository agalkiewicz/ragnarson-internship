module Shop
  module Models
    class BasketRecord
      attr_reader :id, :product_id, :product_name, :value_netto, :value_brutto,
                  :quantity, :sum_netto, :sum_brutto

      @@id = 0

      def initialize(product_id, amount)
        product = Services::FetchProduct.new.call(product_id)
        @id = set_id
        @product_id = product_id
        @product_name = product.name
        @value_netto = product.price
        @value_brutto = calculate_value_brutto(product.vat)
        @quantity = amount
        @sum_brutto = value_brutto * amount
      end

      def add(amount)
        @quantity += amount
        @sum_brutto += amount * value_brutto
      end

      def delete
        @quantity -= 1
        @sum_brutto -= value_brutto
      end

      private
      def set_id
        @@id += 1
      end

      def calculate_value_brutto(vat)
        (value_netto * (1 + vat)).round(2)
      end
    end
  end
end
