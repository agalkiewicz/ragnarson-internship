require_relative '../../../lib/services/delete_product_from_basket'

RSpec.describe Shop::DeleteProductFromBasket do
  subject(:basket) { Shop::Services::DeleteProductFromBasket.new }

  before do
    allow(Shop).to receive(BASKET.list_of_basket_records).and_return([])
    Shop::BASKET.list_of_basket_records.clear
  end

  describe "#call" do
    context "valid id" do
      let(:quantity) { 1 }
      let!(:add_to_basket) { Shop::BASKET.list_of_basket_records << Shop::Item.new(product_id: 1, quantity: quantity) }
      let(:first_warehouse) { Shop::WAREHOUSE.first }

      it "reduce quantity" do
        expect {
          warehouse.call(first_warehouse.id)
        }.to change{ first_warehouse.quantity }.from(quantity).to(quantity-1)
      end
    end
  end
end
