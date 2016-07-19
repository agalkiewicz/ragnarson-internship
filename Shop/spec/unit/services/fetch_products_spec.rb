RSpec.describe Shop::FetchProducts do
  before(:all) do
    Shop::PRODUCTS = Shop::Products.new
  end

  subject(:fetch_products) { Shop::FetchProducts.new }

  context "#call" do
    it "returns proper object" do
      expect(fetch_products.call).to eql(Shop::PRODUCTS)
    end
  end
end
