module Shop
  class Depot
    attr_accessor :list_of_depot_records

    NoProductException = Class.new(StandardError)

    def initialize
      @list_of_depot_records = []
    end

    def find(product_id)
      list_of_depot_records.find { |record| record.product_id == product_id }
    end
  end
end
