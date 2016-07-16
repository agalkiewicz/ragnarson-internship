require "spec_helper"

RSpec.describe Shop::Services::AddProductToBasket do
  before do
        Shop::PRODUCTS = Shop::Models::Products.new
        Shop::BASKET = Shop::Models::Basket.new
        Shop::DEPOT = Shop::Models::Depot.new
      end
      before { Shop::Services::CreateDepot.new.call }
      #let(:new_basket_record) { BasketRecord.new(1, 1) }
      before { Shop::BASKET.list_of_basket_records << BasketRecord.new(1, 1) }
      let (:found_basket_record) do
        Shop::BASKET.list_of_basket_records.find do |record|
          record.product_id == 1
        end
      end
  subject(:basket) { Shop::Services::AddProductToBasket.new }
  let(:params) { { "product_id" => "1", "quantity" => "1" } }

  describe "#call" do
    context "existing basket record" do

      it "increases basket record quantity by specific amount" do
        expect {
          basket.call(params)
        }.to change{ found_basket_record.quantity }.by(1)
      end
    end
  end
end

=begin
require_relative '../../../lib/services/delete_item_from_warehouse'

RSpec.describe Shop::DeleteItemFromWarehouse do
  subject(:warehouse) { Shop::DeleteItemFromWarehouse.new }

  before do
    allow(Shop).to receive(:WAREHOUSE).and_return([])
    Shop::WAREHOUSE.clear
  end

  describe "#call" do
    context "invalid id" do
      it "raises no error" do
        expect {
          warehouse.call(nil)
        }.to_not raise_error
      end
    end

    context "valid id" do
      let(:quantity) { 10 }
      let!(:add_to_warehouse) { Shop::WAREHOUSE << Shop::Item.new(product_id: 1, quantity: quantity) }
      let(:first_warehouse) { Shop::WAREHOUSE.first }

      it "reduce quantity" do
        expect {
          warehouse.call(first_warehouse.id)
        }.to change{ first_warehouse.quantity }.from(quantity).to(quantity-1)
      end
    end
  end
=end
