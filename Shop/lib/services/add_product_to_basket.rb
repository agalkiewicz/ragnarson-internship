module Shop
  class AddProductToBasket
    def initialize(params)
      @product_id = params.fetch("product_id").to_i
      @quantity = params.fetch("quantity").to_i
    end

    def call
      decrease_depot_record_quantity
      increase_basket_record_quantity
    end

    private

    def increase_basket_record_quantity
      basket_record = FetchBasketRecord.new.call(@product_id)
      if basket_record
        basket_record.add(@quantity)
      else
        FetchBasket.new.call.add(@product_id, @quantity)
      end
    end

    def decrease_depot_record_quantity
      depot_record = FetchDepotRecord.new.call(@product_id)
      raise Depot::NoProductException if depot_record.quantity < @quantity
      depot_record.decrease(@quantity)
    end
  end
end
