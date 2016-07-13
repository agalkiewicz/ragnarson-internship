require_relative '../../lib/shop'

RSpec.describe Shop do
  before(:all) do
    @shop = Shop.new
  end

  context "#products" do
    context "when Shop object is created" do
      it "products array is initialized with objects" do
        expect(@shop.products).not_to be_empty
      end
    end

    context "during iteration through products array" do
      it "Product objects are returned" do
        @shop.products.each do |product|
          expect(product).to be_an_instance_of(Product)
        end
      end
    end
  end

  context "#get_product(id)" do
    context "when id < 0" do
      it "returns nil" do
        expect(@shop.product(-1)).to be_nil
      end
    end

    context "when id is a string" do
      it "returns nil" do
        expect(@shop.product("1")).to be_nil
      end
    end
  end
end
