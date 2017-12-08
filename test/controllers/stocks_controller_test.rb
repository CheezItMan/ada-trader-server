require "test_helper"

describe StocksController do
  it "should get index" do
    get stocks_path
    must_respond_with :success
  end

  it "should get show" do
    get stock_path(stocks(:apple).id)
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

end
