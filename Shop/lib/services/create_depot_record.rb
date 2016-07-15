module Shop
  module Services
    class CreateDepotRecord
      def call(product_id, quantity)
        FetchListOfDepotRecords.new.call << Models::DepotRecord.new(product_id, quantity)
      end
    end
  end
end
