RSpec.describe Shop::AddProductToBasket do
  before(:all) do
    Shop::PRODUCTS = Shop::Products.new
    Shop::BASKET   = Shop::Basket.new
    Shop::DEPOT    = Shop::Depot.new
    Shop::CreateDepot.new.call
  end

  describe "#call" do
    before(:context) do
      Shop::BASKET.list_of_basket_records << Shop::BasketRecord.new(1, 1)
    end

    context "when the basket record exists" do
      let(:valid_amount) { 1 }
      let(:invalid_amount) { 12 }
      let(:product_id) { 1 }
      let(:valid_params) { { "product_id" => "#{product_id}", "quantity" => "#{valid_amount}" } }
      let(:invalid_params) { { "product_id" => "#{product_id}", "quantity" => "#{invalid_amount}" } }
      let(:found_depot_record) do
        Shop::DEPOT.list_of_depot_records.find { |record| record.product_id == product_id }
      end
      let(:found_basket_record) do
        Shop::BASKET.list_of_basket_records.find { |record| record.product_id == product_id }
      end

      context "when quantity of depot record >= amount" do
        subject(:valid_subject) { Shop::AddProductToBasket.new(valid_params) }

        it "increases its quantity by specific amount" do
          expect {
            valid_subject.call
          }.to change{ found_basket_record.quantity }.by(valid_amount)
        end

        it "decreases related depot record quantity by specific amount" do
          expect {
            subject.call
          }.to change{ found_depot_record.quantity }.by(-valid_amount)
        end
      end

      context "when quantity of depot_record < amount" do
        subject(:invalid_subject) { Shop::AddProductToBasket.new(invalid_params) }

        it "raises NoProductException" do
          expect {
            invalid_subject.call
          }.to raise_error(Shop::Depot::NoProductException)
        end
      end
    end

    context "when basket record doesn't exist" do
      let(:valid_amount) { 2 }
      let(:invalid_amount) { 12 }
      let(:product_id) { 2 }
      let(:valid_params) { { "product_id" => "#{product_id}", "quantity" => "#{valid_amount}" } }
      let(:invalid_params) { { "product_id" => "#{product_id}", "quantity" => "#{invalid_amount}" } }
      let(:found_basket_record) do
        Shop::BASKET.list_of_basket_records.find { |record| record.product_id == product_id }
      end

      context "when quantity of depot record >= amount" do
        subject(:valid_subject) { Shop::AddProductToBasket.new(valid_params) }

        it "creates new basket record" do
          expect {
            valid_subject.call
          }.to change{ Shop::BASKET.list_of_basket_records.size }.by(1)
        end

        it "initializes new basket record with quantity=amount" do
          expect(found_basket_record.quantity).to eql(valid_amount)
        end
      end

      context "when quantity of depot_record < amount" do
        subject(:invalid_subject) { Shop::AddProductToBasket.new(invalid_params) }

        it "raises NoProductException" do
          expect {
            invalid_subject.call
          }.to raise_error(Shop::Depot::NoProductException)
        end
      end
    end
  end
end
