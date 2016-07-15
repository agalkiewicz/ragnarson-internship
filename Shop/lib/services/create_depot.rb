module Shop
  module Services
    class CreateDepot
      def call
        FetchListOfProducts.new.call.each do |product|
          FetchDepot.new.call
            .list_of_depot_records
            .push(Models::DepotRecord.new(product.id, rand(11) + 2))
        end
      end
    end
  end
end
