module Shop
  class CreateDepotRecord
    def call(product_id, quantity)
      FetchListOfDepotRecords.new.call << DepotRecord.new(product_id, quantity)
    end
  end
end
