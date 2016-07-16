require "bundler/setup"
require "sinatra/base"
require "sinatra/flash"

Dir["./lib/**/*.rb"].each { |file| require file }

module Shop
  PRODUCTS = Products.new
  DEPOT    = Depot.new
  BASKET   = Basket.new

  CreateDepot.new.call

  class App < Sinatra::Base
    enable :sessions
    register Sinatra::Flash
    set :method_override, true

    get "/" do
      products = FetchListOfProducts.new.call
      erb :"products/index", locals: { products: products, title: "Products" }
    end

    get "/products/:id" do |id|
      begin
        product = FetchProduct.new.call(id)
        erb :"products/show", locals: { product: product }
      rescue Products::NoProductFoundException
        flash[:error] = "There is no product of this ID available."
        redirect "/"
      end
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

    put "/basket" do
      DeleteProductFromBasket.new.call(params[:product_id])
      flash[:notice] = "Product was deleted."
      redirect "/basket"
    end

    get "/contact" do
      erb :"static/contact"
    end
  end
end
