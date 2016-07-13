module Shop
  class AddProductToBasket
    def call(product_id)
      decrease_depot_record_quantity(product_id)
      increase_basket_record_quantity(product_id)
    end

    private
    def increase_basket_record_quantity(product_id)
      basket_record = FetchBasketRecord.new.call(product_id)
      basket_record ? basket_record.add : CreateBasketRecord.new.call(product_id)
    end

    def decrease_depot_record_quantity(product_id)
      depot_record = FetchDepotRecord.new.call(product_id)
      raise Depot::NoProductException if depot_record.quantity == 0
      depot_record.decrease
    end
  end
end
