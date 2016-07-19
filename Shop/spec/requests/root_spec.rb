require "web_helper"

RSpec.describe "GET /", type: :request do
  before do
    do_request
  end

  it "returns 200 HTTP code" do
    expect(last_response.status).to eql(200)
  end

  it "returns valid html Content-Type" do
    expect(last_response.headers["Content-Type"]).to eq("text/html;charset=utf-8")
  end

  it "includes h1 element" do
    expect(last_response.body).to include("<h1>")
  end

  it "includes h2 element" do
    expect(last_response.body).to include("<h2>")
  end

  it "returns link to basket" do
    expect(last_response.body).to include("<a href=\/basket>Basket<\/a>")
  end

  it "returns links to products" do
    expect(last_response.body).to include("href=\"\/products\/")
  end

  private

  def do_request
    get "/"
  end
end
