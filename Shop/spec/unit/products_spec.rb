require_relative '../../lib/products'

RSpec.describe Products do
  before(:all) do
    @products = Products.new
  end

  context "#products" do
    context "when Products object is created" do
      it "products array is initialized with objects" do
        expect(@products.products).not_to be_empty
      end
    end

    context "during iteration through products array" do
      it "Product objects are returned" do
        @products.products.each do |product|
          expect(product).to be_an_instance_of(Product)
        end
      end
    end
  end

  context "#get_product(id)" do
    context "when id < 0" do
      it "returns nil" do
        expect(@products.get_product(-1)).to be_nil
      end
    end

    context "when id is a string" do
      it "returns nil" do
        expect(@products.get_product("1")).to be_nil
      end
    end
  end
end
