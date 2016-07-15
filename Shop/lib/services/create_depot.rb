module Shop
  module Services
    class CreateDepot
      def call
        FetchListOfProducts.new.call
          .each { |product| CreateDepotRecord.new.call(product.id, rand(11)) }
      end
    end
  end
end
