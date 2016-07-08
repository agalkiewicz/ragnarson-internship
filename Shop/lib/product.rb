class Product
  attr_reader :id
  attr_accessor :name, :price, :vat

  @@id = 0

  def initialize(name:, price:, vat:)
    raise ArgumentError if name.nil? || price.nil? || vat.nil?
    raise ArgumentError if price <= 0
    raise ArgumentError if vat <= 0 || vat > 0.23
    @id = next_id
    @name = name
    @price = price.round(2)
    @vat = vat
  end

  def to_s
    "#{@id}".ljust(4) + "#{@name}".ljust(10) + "#{'%.2f' % @price}zl".ljust(10) +
    "#{@vat}".ljust(10)
  end

  private
  def next_id
    @@id += 1
  end
end
