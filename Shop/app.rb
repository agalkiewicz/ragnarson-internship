require "bundler/setup"
require "sinatra/base"
require "sinatra/flash"

Dir["./lib/**/*.rb"].each { |file| require file }

module Shop
  PRODUCTS = Models::Products.new
  DEPOT = Models::Depot.new
  BASKET = Models::Basket.new

  Services::CreateDepot.new.call

  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Flash
    set :method_override, true

    get "/" do
      products = Services::FetchListOfProducts.new.call
      erb :"products/index", locals: { products: products, title: "Products" }
    end

    get "/products/:id" do |id|
      begin
        product = Services::FetchProduct.new.call(id)
        erb :"products/show", locals: { product: product }
      rescue Models::Products::NoProductFoundException
        flash[:error] = "There is no product of this ID available."
        redirect "/"
      end
    end

    get "/basket" do
      basket = Services::FetchBasket.new.call
      erb :"basket/show", locals: { basket: basket }
    end

    post "/basket" do
      begin
        Services::AddProductToBasket.new(params).call
        flash[:notice] = "Product was added."
        redirect "/basket"
      rescue Models::Depot::NoProductException
        flash[:error] = "There are not so many products in a depot."
        redirect "/"
      end
    end

    put "/basket" do
      Services::DeleteProductFromBasket.new.call(params[:product_id])
      flash[:notice] = "Product was deleted."
      redirect "/basket"
    end

    get "/contact" do
      erb :"static/contact"
    end
  end
end
