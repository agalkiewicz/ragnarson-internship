RSpec.describe Shop::Services::FetchProducts do
  subject(:fetch_products) { Shop::Services::FetchProducts.new }
  #let(:basket) { Shop::Basket.new }
  #let(:product) { Shop::Product.new("foo", 5, 10) }

  before do
    #Shop::PRODUCTS
    #allow(Shop).to receive(:PRODUCTS).and_return(:PRODUCTS)
    #Shop::PRODUCTS << product
  end

  context "#call" do
    it "returns Products class object" do
      expect(fetch_products.call).to be_an_instance_of(Products)
    end

    xit "raise no error" do
      expect {
        fetch_product.call(nil)
      }.to_not raise_error
    end

    xit "return proper product" do
      expect(fetch_product.call(product.id)).to eql(product)
    end

    xit "return nil when argument is not valid product id" do
      expect(fetch_product.call(1000)).to eql(nil)
    end
  end
end
