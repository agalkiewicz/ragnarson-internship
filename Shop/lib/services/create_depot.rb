module Shop
  class CreateDepot
    def call
      FetchListOfProducts.new.call.each do |product|
        FetchDepot.new.call
          .list_of_depot_records
          .push(DepotRecord.new(product.id, rand(11) + 3))
      end
    end
  end
end
