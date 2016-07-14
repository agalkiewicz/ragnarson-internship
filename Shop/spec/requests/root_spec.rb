require "web_helper"

RSpec.describe "GET /", type: :request do
  before do
    do_request
  end

  it "returns 200 HTTP code" do
    expect(last_response.status).to eql(200)
  end

  it "returns valid html Content-Type" do
    expect(last_response.headers["Content-Type"]).to include("text/html")
  end

  it "returns h1 element with 'Welcome to Alice's Shop' value" do
    expect(last_response.body).to include("<h1>Welcome to Alice's Shop</h1>")
  end

  it "returns h2 element with 'Products' value" do
    expect(last_response.body).to include("<h2>Products</h2>")
  end

  it "returns link to basket" do
    expect(last_response.body).to include("Basket")
  end

  private
  def do_request
    get "/"
  end
end
