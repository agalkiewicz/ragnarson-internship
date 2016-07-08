require_relative "./basket_record"

class Basket
  attr_accessor :basket

  def initialize
    @basket = []
  end

  def add(product)
    found = @basket.find { |record| record.product == product }
    found.nil? ? @basket << BasketRecord.new(product) : found.add
  end

  def delete(id)
    found = @basket.find { |record| record.product.id == id }
    if found.nil?
      false
    else
      if found.quantity == 1
        @basket.delete(found)
        true
      else
        found.delete
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
