require "test_helper"

describe StocksController do
  before do

  end
  it "should get index" do
    get stocks_path

    body = JSON.parse(response.body)
    body.must_be_kind_of Array
    must_respond_with :success
  end

  it "returns json" do
      get stocks_path
      response.header['Content-Type'].must_include 'json'
  end

  it "should get show with correct fields" do
    skip
    # this isn't working due to Serializers not working in test mode, not sure how to fix
    get stock_path(stocks(:apple).id)

    keys = %w(id name price symbol)

    body = JSON.parse(response.body)
    body.keys.sort.must_equal keys

    must_respond_with :success
  end

  it "should respond with an error for an invalid id" do
    apple = stocks(:apple)
    apple_id = apple.id

    apple.destroy

    get stock_path(apple_id)
    must_respond_with :not_found
  end



  it "should get delete" do
    delete stock_path(stocks(:apple).id)
    must_respond_with :success
  end

  it "should return an error for an invalid id on destory " do
    apple_id = stocks(:apple).id
    stocks(:apple).destroy
    delete stock_path(apple_id)
    must_respond_with :not_found
  end

  it "Can update a stock" do

    apple = stocks(:apple)
    apple_data = {
      name: "Peach",
      symbol: 'PEA',
      price: 0.99
    }

    patch stock_path(apple.id), params: apple_data

    must_respond_with :success

    apple = Stock.find_by(id: apple.id)
    apple.name.must_equal "Peach"
    apple.symbol.must_equal "PEA"
    apple.price.must_equal 0.99

  end

  it "gets an error updating a stock invalidly" do
    apple = stocks(:apple)
    apple_data = {
      name: "Peach",
      symbol: 'PEACH',  # too damm long
      price: 0.99
    }

    patch stock_path(apple.id), params: apple_data

    must_respond_with :bad_request

    apple = Stock.find_by(id: apple.id)
    apple.name.must_equal "Apple"
    apple.symbol.must_equal "AAPL"
  end

  it "gets an error updating a deleted stock" do
    apple = stocks(:apple)
    apple_data = {
      name: "Peach",
      symbol: 'PEA',  # too damm long
      price: 0.99
    }
    apple_id = apple.id

    apple.destroy

    patch stock_path(apple_id), params: apple_data

    must_respond_with :bad_request
  end

  it "can create a stock" do
    stock_data = {
      name: 'Chris Corp',
      symbol: 'CCP',
      price: 1000000
    }

    post stocks_path, params: stock_data

    must_respond_with :success

    stock = Stock.find_by name: 'Chris Corp'
    stock.name.must_equal 'Chris Corp'
    stock.price.must_equal 1000000
    stock.symbol.must_equal 'CCP'
  end

end
