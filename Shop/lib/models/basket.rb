module Shop
  class Basket
    attr_accessor :list_of_basket_records

    def initialize
      @list_of_basket_records = []
    end

    def add(product_id)
      new_basket_record = BasketRecord.new(product_id)
      list_of_basket_records << new_basket_record
    end

    def delete(product_id)
      basket_record = FetchBasketRecord.new.call(product_id)
      list_of_basket_records.delete(basket_record)
    end

    def find(product_id)
      list_of_basket_records.find { |record| record.product_id == product_id }
    end

    def sum_brutto
      list_of_basket_records.map(&:sum_brutto).reduce(0, :+)
    end
  end
end
