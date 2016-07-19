require "web_helper"

RSpec.describe "POST /basket", type: :request do
  let(:domain) { "http://example.org" }
  let(:error_message) do
    "<p class=\"alert alert-warning\">There are not so many products in a depot.</p>"
  end
  let(:notice_message) do
    "<p class=\"alert alert-success\">Product was added.</p>"
  end
  let(:example_params) { { "product_id" => "1", "quantity" => "1" } }

  it "call AddProductToBasket with proper params" do
    expect(Shop::AddProductToBasket).to receive(:new).with(example_params).and_call_original

    do_request(example_params)
  end

  context "invalid params" do
    let(:invalid_params) { { product_id: 1, quantity: 11 } }

    before do
      do_request(invalid_params)
      follow_redirect!
    end

    it "returns 200 HTTP status code" do
      expect(last_response.status).to eql(200)
    end

    it "redirects to /" do
      expect(last_request.url). to eql(domain + "/")
    end

    it "shows flash error message" do
      expect(last_response.body).to include(error_message)
    end
  end

  context "valid params" do
    let(:valid_params)   { { product_id: 1, quantity: 1 } }

    before do
      do_request(valid_params)
      follow_redirect!
    end

    it "returns 200 HTTP status code" do
      expect(last_response.status).to eql(200)
    end

    it "redirects to /basket" do
      expect(last_request.url). to eql(domain + "/basket")
    end

    it "shows flash notice message" do
      expect(last_response.body).to include(notice_message)
    end
  end

  private

  def do_request(params = {})
    post "/basket", params
  end
end
