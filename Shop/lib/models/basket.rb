module Shop
  class Basket
    attr_accessor :list_of_basket_records

    NoProductFoundException = Class.new(StandardError)

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

    def to_s
      "Id".ljust(4) +
      "Product_id".ljust(15) +
      "Quantity".ljust(10) +
      "Value netto".ljust(13) +
      "Value brutto".ljust(13) + "\n" +
      list_of_basket_records.map(&:to_s).join("\n") +
      "\n" + " " * 29 + "Sum netto".ljust(13) +
      "Sum brutto".ljust(13) +
      "\n" + " " * 29 + "#{'%.2f' % sum_netto}".ljust(13) +
      "#{'%.2f' % sum_brutto}".ljust(13)
    end

    def sum_brutto
      list_of_basket_records.map(&:sum_brutto).reduce(0, :+)
    end

    private
    def sum_netto
      list_of_basket_records.map(&:sum_netto).reduce(0, :+)
    end
  end
end
