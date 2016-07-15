module Shop
  module Services
    class FetchDepotRecord
      def call(product_id)
        FetchDepot.new.call.find(product_id)
      end
    end
  end
end
