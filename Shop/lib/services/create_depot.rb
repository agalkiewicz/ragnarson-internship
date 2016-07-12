module Shop
  class CreateDepot
    def call
      FetchListOfProducts.new.call.each { |product| CreateDepotRecord.new.call(product.id, rand(10)) }
    end
  end
end
