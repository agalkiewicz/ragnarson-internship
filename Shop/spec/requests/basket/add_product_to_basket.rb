require "web_helper"

RSpec.describe "POST /basket", type: :request do
  context "invalid params" do
    let(:invalid_params) { { "product_id" => "1", "quantity" => "11" } }
    let(:domain)         { "http://example.org" }

    before do
      do_request(invalid_params)
    end

    it "redirects us" do
      expect(last_response).to  be_redirect
    end

    it "returns 200 HTTP status code" do
      follow_redirect!
      expect(last_response.status).to eql(200)
    end

    it "redirects to /" do
      follow_redirect!
      expect(last_request.url). to eql(domain + "/")
    end

    it "shows flash message" do
      follow_redirect!
      expect(last_response.body).to include("There are not so many products in a depot.")
    end

    it "shows flash error message" do
      follow_redirect!
      expect(last_response.body).to include("class=\"alert alert-warning\"")
    end
  end

  context "valid params" do
    let(:params) { { product_id: 1, quantity: 0 } }
    let(:domain) { "http://example.org" }

    before do
      do_request(params)
    end

    it "redirects us" do
      expect(last_response).to  be_redirect
    end

    it "returns 200 HTTP status code" do
      follow_redirect!
      expect(last_response.status).to eql(200)
    end

    it "redirects to /basket" do
      follow_redirect!
      expect(last_request.url). to eql(domain + "/basket")
    end

    it "shows flash message" do
      follow_redirect!
      expect(last_response.body).to include("Product was added.")
    end

    it "shows flash notice message" do
      follow_redirect!
      expect(last_response.body).to include("class=\"alert alert-success\"")
    end
  end

  it "call AddProductToBasket with proper params" do
    params =  { "product_id" => "1", "quantity" => "0" }

    expect(Shop::AddProductToBasket).to receive(:new).with(params).and_call_original

    do_request(params)
  end

  private
  def do_request(params={})
    post "/basket", params
  end
end
