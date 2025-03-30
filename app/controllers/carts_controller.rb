class CartsController < ApplicationController
  def index
    @carts = Cart.limit(3) # TODO: paginate

    render json: @carts.map(&:describe)
  end

  def show
    @cart = Cart.find(id)
    render json: @cart.describe
  end

  private

  def id
    params.expect(:id)
  end
end
