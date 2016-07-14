module Shop
  class BasketRecord
    attr_reader :id, :product_id, :product_name, :product_price, :value_netto,
                :value_brutto, :quantity, :sum_netto, :sum_brutto

    @@id = 0

    def initialize(product_id)
      product = FetchProduct.new.call(product_id)
      @id = set_id
      @product_id = product_id
      @product_name = product.name
      @product_price = product.price
      @value_netto = product.price
      @value_brutto = calculate_value_brutto(product.vat)
      @quantity = 1
      @sum_netto = value_netto
      @sum_brutto = value_brutto
    end

    def add(amount)
      @quantity += amount
      @sum_netto += amount * value_netto
      @sum_brutto += amount * value_brutto
    end

    def delete
      @quantity -= 1
      @sum_netto -= value_netto
      @sum_brutto -= value_brutto
    end

    def to_s
      "#{id}".ljust(4) +
      "#{product_id}".ljust(15) +
      "#{quantity}".ljust(10) +
      "#{'%.2f' % sum_netto}".ljust(13) +
      "#{'%.2f' % sum_brutto}".ljust(13)
    end

    private
    def set_id
      @@id += 1
    end

    def calculate_value_brutto(vat)
      (value_netto * (1 + vat)).round(2)
    end
  end
end
