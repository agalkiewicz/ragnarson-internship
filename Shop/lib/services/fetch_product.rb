module Shop
  module Services
    class FetchProduct
      def call(product_id)
        FetchProducts.new.call
          .find(product_id.to_i)
      end
    end
  end
end
