module Shop
  module Services
    class FetchListOfDepotRecords
      def call
        FetchDepot.new.call.list_of_depot_records
      end
    end
  end
end
