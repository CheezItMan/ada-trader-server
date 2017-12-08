class StocksController < ApplicationController
  def index
    stocks = Stock.all
    render json: stocks, status: :ok
  end

  def show
    stock = Stock.find_by(id: params[:id])

    if stock
      render json: stock.as_json
    else
      render(
        json: {
          "ok": false,
          "errors": {
            "id": ["Could not find a stock with id #{params[:id]}"]
          }
        },
        status: :not_found
      )
    end
  end

  def update
    stock = Stock.find_by(id: params[:id])
    if stock.update stock_params
      render(
        json: stock.as_json(only: [:id]), status: :ok
      )
    else
      render(
        json: {"ok" => false,
               "errors" => stock.errors.messages
              }, status: :bad_request)
    end
  end

  def destroy
    stock = Stock.find_by(id: params[:id])
    if stock
      stock.destroy
      render( stock.as_json, status: :ok)
    else
      render(
        json: {
          "ok": false,
          "errors": {
            "id": ["Could not find a stock with id #{params[:id]}"]
          }
        },
        status: :not_found
      )
    end
  end

  def create
    stock = Stock.new stock_params

    if stock.save
      render(
        json: stock.as_json(only: [:id]), status: :ok
      )
    else
      render(
        json: {"ok" => false,
               "errors" => stock.errors.messages
              }, status: :bad_request)
    end

  end

  private
    def stock_params
      params.permit(:name, :symbol, :price)
    end

end
