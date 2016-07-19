RSpec.describe Shop::Products do
  before(:all) do
    Shop::PRODUCTS = Shop::Products.new
  end

  context "#list_of_products" do
    subject { Shop::Products.new.list_of_products }

    context "when Products object is created" do
      it "list_of_products array is initialized with objects" do
        expect(subject).not_to be_empty
      end
    end

    context "during iteration through list_of_products array" do
      it "Product objects are returned" do
        subject.each do |product|
          expect(product).to be_an_instance_of(Shop::Product)
        end
      end
    end

    context "when try to change list_of_products array" do
      let(:products_to_add) do
        [
          Shop::Product.new(name: "foo", price: 12, vat: 0.08),
          Shop::Product.new(name: "bar", price: 12.25, vat: 0.23)
        ]
      end

      it "raises NoMethodError" do
        expect {
          Shop::PRODUCTS.list_of_products = products_to_add
        }.to raise_error(NoMethodError)
      end
    end
  end

  context "#find" do
    context "when invalid product_id given" do
      it "raises NoProductFoundException" do
        expect {
          Shop::PRODUCTS.find(-1)
        }.to raise_error(Shop::Products::NoProductFoundException)
      end
    end

    context "when valid product_id given" do
      let(:product_id) { 1 }
      subject(:found_product) { Shop::PRODUCTS.find(product_id) }

      it "returns proper object" do
        expect(found_product.id).to eq(product_id)
      end
    end
  end
end
