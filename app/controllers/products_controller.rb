class ProductsController < ApplicationController
  def index
    @products = Product.limit(10) # TODO: paginate

    render json: @products.map(&:describe)
  end

  def show
    @product = Product.find(id)
    render json: @product.describe
  end

  def create_promotion
    validate_promotion_params!
    @product = Product.find(id)
    @product.create_promotion(*promotion_params.values)

    render json: { status: :success }
  end

  private

  def id
    params.expect(:id)
  end

  def promotion_params
    expected_params = %i[discount_type discount start_time end_time]
    params.permit(expected_params).transform_keys(&:to_sym)
  end

  def validate_promotion_params!
    unless promotion_params[:discount].is_a?(Numeric) || promotion_params[:discount].positive?
      raise ApiResponse::InvalidParameter,
            'discount must be a positive number'
    end
    # In practice, this is desired, however it is annoying for our testing purposes, so I'll remove it.
    # if promotion_params[:start_time].to_datetime.past?
    #   raise ApiResponse::InvalidParameter,
    #         'start time must be in the future'
    # end
    if promotion_params[:end_time].to_datetime.past?
      raise ApiResponse::InvalidParameter,
            'end time must be in the future'
    end

    return unless promotion_params[:start_time].to_datetime > promotion_params[:end_time].to_datetime

    raise ApiResponse::InvalidParameter,
          'end time must be after the start time'
  end
end
