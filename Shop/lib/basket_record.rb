require_relative "./product"

class BasketRecord
  attr_reader :sum_netto, :sum_brutto, :product, :quantity, :value_brutto, :value_netto

  def initialize(product)
    @value_netto = product.price
    @value_brutto = (product.price * (1 + product.vat)).round(2)
    @quantity = 1
    @sum_netto = @value_netto
    @sum_brutto = @value_brutto
    @product = product
  end

  def add
    @quantity += 1
    @sum_netto += @value_netto
    @sum_brutto += @value_brutto
  end

  def delete
    @sum_netto -= @value_netto
    @sum_brutto -= @value_brutto
  end

  def to_s
    "#{@product}" + "#{@quantity}".ljust(10) + "#{'%.2f' % @sum_netto}".ljust(13) +
    "#{'%.2f' % @sum_brutto}".ljust(13) + "\n"
  end
end
