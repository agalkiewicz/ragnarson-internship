RSpec.describe Shop::BasketRecord do
  subject(:basket_record) { Shop::BasketRecord.new(product_id, amount) }

  let(:product_id) { 1 }
  let(:amount)     { 2 }

  before(:all) do
    Shop::PRODUCTS = Shop::Products.new
  end

  it "has 2 params" do
    expect {
      basket_record
    }.not_to raise_error
  end

  context "#quantity" do
    context "when BasketRecord object is created" do
      it "its quantity equals to number given" do
        expect(basket_record.quantity).to eql(amount)
      end
    end

    context "on change attempt" do
      it "raises NoMethodError" do
        expect {
          basket_record.quantity = 0
        }.to raise_error(NoMethodError)
      end
    end
  end

  context "#product_id" do
    context "when BasketRecord object is created" do
      it "product_id is equal to given id" do
        expect(basket_record.product_id).to eql(product_id)
      end
    end

    context "on change attempt" do
      it "raises NoMethodError" do
        expect {
          basket_record.product_id = 2
        }.to raise_error(NoMethodError)
      end
    end
  end

  context "#product_name" do
    context "when BasketRecord object is created" do
      let(:found_product) do
        Shop::PRODUCTS.list_of_products.find { |product| product.id == product_id }
      end

      it "product_name is equal to name of product given" do
        expect(basket_record.product_name).to eql(found_product.name)
      end
    end

    context "on change attempt" do
      it "raises NoMethodError" do
        expect {
          basket_record.product_name = "asadjsadosi"
        }.to raise_error(NoMethodError)
      end
    end
  end

  context "#value_brutto" do
    context "on change attempt" do
      it "raises NoMethodError" do
        expect {
          basket_record.value_brutto = 34.50
        }.to raise_error(NoMethodError)
      end
    end
  end

  context "#sum_brutto" do
    let(:sum_brutto) { basket_record.value_brutto * amount }

    context "when BasketRecord object is created" do
      it "sum_brutto = amount * value_brutto" do
        expect(basket_record.sum_brutto).to eq(sum_brutto)
      end
    end

    context "on change attempt" do
      it "raises NoMethodError" do
        expect {
          basket_record.sum_brutto = 0.00
        }.to raise_error(NoMethodError)
      end
    end
  end

  context "#add" do
    let(:difference) { basket_record.value_brutto * amount }
    subject { basket_record.add(amount) }

    it "quantity is increased by amount given" do
      expect{ subject }.to change{ basket_record.quantity }.by(amount)
    end

    it "sum_brutto is increased by value_brutto * amount" do
      expect{ subject }.to change{ basket_record.sum_brutto }.by(difference)
    end
  end

  context "#delete" do
    subject { basket_record.delete }

    it "quantity is decreased by 1" do
      expect{ subject }.to change{ basket_record.quantity }.by(-1)
    end

    it "sum_brutto is decreased by value_brutto" do
      expect{ subject }.to change{ basket_record.sum_brutto }.by(-basket_record.value_brutto)
    end
  end
end
