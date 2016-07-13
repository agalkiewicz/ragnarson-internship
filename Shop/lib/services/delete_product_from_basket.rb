module Shop
  class DeleteProductFromBasket
    def call(product_id)
      increase_depot_record_quantity(product_id)
      decrease_basket_record_quantity(product_id)
    end

    private
    def decrease_basket_record_quantity(product_id)
      basket_record = FetchBasketRecord.new.call(product_id)
      raise Basket::NoProductFoundException unless basket_record
      if basket_record.quantity == 1
        DeleteBasketRecord.new.call(product_id)
      else
        basket_record.delete
      end
    end

    def increase_depot_record_quantity(product_id)
      depot_record = FetchDepotRecord.new.call(product_id)
      depot_record.increase
    end
  end
end
