require "web_helper"

RSpec.describe "GET /products/:id", type: :request do
  context "without existing product" do
    let(:domain) { "http://example.org" }

    before do
      do_request(100)
    end

    it "redirects us" do
      expect(last_response).to  be_redirect
    end

    it "returns 202 HTTP code" do
      follow_redirect!
      expect(last_response.status).to eql(200)
    end

    it "redirect to HOME" do
      follow_redirect!
      expect(last_request.url). to eql(domain + "/")
    end

    it "shows flash message" do
      follow_redirect!
      expect(last_response.body).to include("There is no product of this ID available.")
    end

    it "shows flash error message" do
      follow_redirect!
      expect(last_response.body).to include("class=\"alert alert-warning\"")
    end
  end

  context "with existing product" do
    let(:product) { Shop::FetchProduct.new.call(1) }

    before do
      do_request(product.id)
    end

    it "returns 200 HTTP code" do
      expect(last_response.status).to eql(200)
    end

    it "returns valid html Content-Type" do
      expect(last_response.headers["Content-Type"]).to include("text/html")
    end

    it "contains product name" do
      expect(last_response.body).to include("#{product.name}")
    end
  end

  before do
    do_request(1)
  end

  it "contains HTML input form" do
    expect(last_response.body).to include("<\/form>")
  end

  context "HTML form" do
    it "is associated with POST request" do
      expect(last_response.body).to include("method=\"post\"")
    end
  end

  private
  def do_request(id)
    get "/products/#{id}"
  end
end
