require "web_helper"

RSpec.describe "GET /products/:id", type: :request do
  before do
    do_request(id: 1)
  end

  context "without existing product" do
    let(:domain) { "http://example.org" }
    let(:error_message) do
      "<p class=\"alert alert-warning\">There is no product of this ID available.</p>"
    end

    before do
      do_request(id: 100)
      follow_redirect!
    end

    it "returns 202 HTTP code" do
      expect(last_response.status).to eql(200)
    end

    it "redirects to HOME" do
      expect(last_request.url). to eql(domain + "/")
    end

    it "shows flash error message" do
      expect(last_response.body).to include(error_message)
    end
  end

  context "with existing product" do
    let(:product) { Shop::FetchProduct.new.call(1) }

    before do
      do_request(id: product.id)
    end

    it "returns 200 HTTP code" do
      expect(last_response.status).to eql(200)
    end

    it "returns valid html Content-Type" do
      expect(last_response.headers["Content-Type"]).to eq("text/html;charset=utf-8")
    end

    it "contains product name" do
      expect(last_response.body).to include("#{product.name}")
    end
  end

  context "HTML form" do
    it "is set" do
      expect(last_response.body).to include("<\/form>")
    end

    it "is associated with POST request" do
      expect(last_response.body).to include("method=\"post\"")
    end

    it "has input of type number" do
      expect(last_response.body).to include("input type=\"number\"")
    end

    it "has hidden input with product_id" do
      expect(last_response.body).to include("input type=\"hidden\" name=\"product_id\"")
    end
  end

  private

  def do_request(id:)
    get "/products/#{id}"
  end
end
