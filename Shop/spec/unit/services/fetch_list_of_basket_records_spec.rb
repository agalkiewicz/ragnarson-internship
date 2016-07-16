RSpec.describe Shop::Services::FetchListOfBasketRecords do
  subject(:fetch_list_of_basket_records) { Shop::Services::FetchListOfBasketRecords.new }
  let(:basket_record) { Shop::Models::BasketRecord.new(1, 1) }
  let(:basket) { Shop::Models::Basket.new }

  context "#call" do
    context "immediately after BASKET has been created" do
      it "returns an empty array" do
        Shop::BASKET = basket

        expect(fetch_list_of_basket_records.call).to eql([])
      end
    end

    context "when a basket is not empty" do
      before(:each) do
        Shop::BASKET.list_of_basket_records.clear
      end

      it "returns proper array of elements" do
        Shop::BASKET.list_of_basket_records << basket_record

        expect(fetch_list_of_basket_records.call).to eql([basket_record])
      end
    end
  end
end
