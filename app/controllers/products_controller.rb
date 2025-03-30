class ProductsController < ApplicationController
  def index
    @products = Product.limit(10) # TODO: paginate

    render json: @products.map(&:describe)
  end

  def show
    @product = Product.find(id)
    # render json: {}, status: :not_found if @product.nil?
    render json: @product.describe
  end

  private

  def id
    params.expect(:id)
  end
end
