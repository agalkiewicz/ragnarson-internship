RSpec.describe Shop::Product do
  let(:name)    { "Foo" }
  let(:price)   { 7 }
  let(:vat)     { 0.08 }

  it "has 1 hash param with 3 keys" do
    expect {
      Shop::Product.new(name: name, price: price, vat: vat)
    }.not_to raise_error
  end

  context "#name" do
    context "when nil" do
      it "raises error" do
        expect {
          Shop::Product.new(name: nil, price: price, vat: vat).name
        }.to raise_error(ArgumentError)
      end
    end
  end

  context "#price" do
    context "when nil" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: nil, vat: vat).price
        }.to raise_error(ArgumentError)
      end
    end

    context "when < 0" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: -2.15, vat: vat).price
        }.to raise_error(ArgumentError)
      end
    end

    context "when equal to 0" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: 0, vat: vat).price
        }.to raise_error(ArgumentError)
      end
    end

    context "when 12.7589 given" do
      it "returns 12.76" do
        expect(Shop::Product.new(name: name, price: 12.7589, vat: vat).price)
          .to eql(12.76)
      end
    end

    context "when 12 given" do
      it "returns 12.0" do
        expect(Shop::Product.new(name: name, price: 12, vat: vat).price)
          .to eql(12.0)
      end
    end

    context "when String object given" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: "1234", vat: vat).price
        }.to raise_error(ArgumentError)
      end
    end
  end

  context "#vat" do
    context "when nil" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: price, vat: nil).vat
        }.to raise_error(ArgumentError)
      end
    end

    context "when < 0" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: price, vat: -0.12).price
        }.to raise_error(ArgumentError)
      end
    end

    context "when equal to 0" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: price, vat: 0).price
        }.to raise_error(ArgumentError)
      end
    end

    context "when > 0.23" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: price, vat: 0.24).price
        }.to raise_error(ArgumentError)
      end
    end

    context "when String object given" do
      it "raises error" do
        expect {
          Shop::Product.new(name: name, price: price, vat: "0.8").price
        }.to raise_error(ArgumentError)
      end
    end
  end
end
