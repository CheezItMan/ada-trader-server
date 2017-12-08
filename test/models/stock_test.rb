require "test_helper"

describe Stock do
  let(:stock) { Stock.new }

  it "must be valid" do
    stocks(:apple).valid?.must_equal true
  end

  it "must be invalid without the required fields" do
    fields = [:name, :symbol, :price]

    invalid_stock = Stock.new

    invalid_stock.valid?.must_equal false

    fields.each do |field|
      invalid_stock.errors.keys.must_include(field)
    end
  end

  it "must have a unique name and symbol" do
    invalid_stock = Stock.new name: stocks(:apple).name, symbol: stocks(:apple).symbol, price: stocks(:apple).price

    invalid_stock.valid?.must_equal false

    fields = [:name, :symbol]
    fields.each do |field|
      invalid_stock.errors.keys.must_include(field)
      invalid_stock.errors[field].must_include "has already been taken"
    end
  end
end
