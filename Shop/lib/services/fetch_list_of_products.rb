module Shop
  class FetchListOfProducts
    def call
      FetchProducts.new.call
        .list_of_products
    end
  end
end
