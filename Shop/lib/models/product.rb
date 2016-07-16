module Shop
  class Product
    attr_reader :id, :name, :price, :vat

    @@id = 0

    def initialize(name:, price:, vat:)
      raise ArgumentError if name.nil? || price.nil? || vat.nil? || price <= 0 ||
        vat <= 0 || vat > 0.23
      @id = set_id
      @name = name
      @price = price.round(2)
      @vat = vat
    end

    private
    def set_id
      @@id += 1
    end
  end
end
