module Shop
  class DepotRecord
    attr_reader :id, :product_id
    attr_accessor :quantity

    @@id = 0

    def initialize(product_id, quantity)
      @id = set_id
      @product_id = product_id
      @quantity = quantity
    end

    def increase
      @quantity += 1
    end

    def decrease(amount)
      @quantity -= amount
    end

    private
    def set_id
      @@id += 1
    end
  end
end
