require_relative '../../lib/basket_record'

RSpec.describe BasketRecord do
  let(:product)       { Product.new(name: "Foo", price: 7, vat: 0.08) }
  let(:basket_record) { BasketRecord.new(product) }

  it "has 1 param" do
    expect {
      basket_record
    }.not_to raise_error
  end

  context "#quantity" do
    context "when BasketRecord object is created" do
      it "quantity = 1" do
        expect(basket_record.quantity).to eql(1)
      end
    end
  end

  context "#sum_netto" do
    context "when BasketRecord object is created" do
      it "sum_netto = value_netto" do
        expect(basket_record.sum_netto).to eql(basket_record.value_netto)
      end
    end
  end

  context "#sum_brutto" do
    context "when BasketRecord object is created" do
      it "sum_brutto = value_brutto" do
        expect(basket_record.sum_brutto).to eql(basket_record.value_brutto)
      end
    end
  end

  context "#add" do
    context "when another product added" do
      it "quantity is increased by 1" do
        before = basket_record.quantity
        basket_record.add
        after = basket_record.quantity
        expect(after - before).to eql(1)
      end
    end

    context "when another product added" do
      it "sum_netto is increased by value_netto" do
        before = basket_record.sum_netto
        basket_record.add
        after = basket_record.sum_netto
        expect(after - before).to eql(basket_record.value_netto)
      end
    end

    context "when another product added" do
      it "sum_brutto is increased by value_brutto" do
        before = basket_record.sum_brutto
        basket_record.add
        after = basket_record.sum_brutto
        expect(after - before).to eql(basket_record.value_brutto)
      end
    end
  end
end
