RSpec.describe Shop::FetchProduct do
  before(:all) do
    Shop::PRODUCTS = Shop::Products.new
  end

  subject(:fetch_product) { Shop::FetchProduct.new }
  let(:example_id) { 1 }
  let(:found_product) do
    Shop::PRODUCTS.list_of_products.find { |product| product.id == example_id }
  end

  context "#call" do
    context "valid param" do
      it "returns Product class object" do
        expect(fetch_product.call("1")).to be_an_instance_of(Shop::Product)
      end

      it "returns proper product" do
        expect(fetch_product.call("#{found_product.id}")).to eql(found_product)
      end
    end

    context "invalid param" do
      it "raises NoProductFoundException" do
        expect {
          fetch_product.call(nil)
        }.to raise_error(Shop::Products::NoProductFoundException)
      end
    end
  end
end
