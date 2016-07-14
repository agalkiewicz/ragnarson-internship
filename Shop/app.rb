require "bundler/setup"
require "sinatra/base"
require "sinatra/flash"

Dir["./lib/**/*.rb"].each { |file| require file }

module Shop
  PRODUCTS = Products.new
  DEPOT = Depot.new
  BASKET = Basket.new

  CreateDepot.new.call

  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Flash

    get "/" do
      products = FetchListOfProducts.new.call
      erb :"products/index", locals: { products: products, title: "Products" }
    end

    get "/products/:id" do |id|
      product = FetchProduct.new.call(id)
      erb :"products/show", locals: { product: product }
    end

    get "/basket" do
      basket = FetchBasket.new.call
      erb :"basket/show", locals: { basket: basket }
    end

    post "/basket" do
      begin
        AddProductToBasket.new(params).call
        flash[:notice] = "Product was added."
        redirect "/basket"
      rescue Depot::NoProductException
        flash[:error] = "There are not so many products in a depot."
        redirect "/"
      end
    end
  end
end
