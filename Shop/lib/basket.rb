require_relative "./basket_record"

class Basket
  attr_accessor :basket

  def initialize
    @basket = []
  end

  def add(product)
    basket_record = @basket.find { |record| record.product == product }
    basket_record.nil? ? @basket << BasketRecord.new(product) : basket_record.add
  end

  def delete(id)
    basket_record = @basket.find { |record| record.product.id == id }
    if basket_record.nil?
      false
    else
      if basket_record.quantity == 1
        @basket.delete(basket_record)
        true
      else
        basket_record.delete
        true
      end
    end
  end

  def sum_netto
    @basket.map { |record| record.sum_netto.round(2) }.reduce(0, :+)
  end

  def sum_brutto
    @basket.map { |record| record.sum_brutto.round(2) }.reduce(0, :+)
  end

  def to_s
    string = "Id".ljust(4) + "Name".ljust(10) + "Price".ljust(10) + "VAT".ljust(10) +
             "Quantity".ljust(10) + "Value netto".ljust(13) + "Value brutto".ljust(13) + "\n"
    @basket.each { |record| string += "#{record}" }
    string += "\n" + " " * 44 + "Sum netto".ljust(13) + "Sum brutto".ljust(13) +
              "\n" + " " * 44 + "#{'%.2f' % sum_netto}".ljust(13) +
              "#{'%.2f' % sum_brutto}".ljust(13)
  end
end
