# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :carts, through: :cart_products
  has_many :cart_products
  has_one :promotion

  def describe
    { id:, name:, brand:, price: }
  end

  def create_promotion(discount_type, discount, start_time, end_time)
    raise ApiResponse::InvalidParameter if discount_type.to_sym == :percentage && (discount.negative? || discount > 1)
    raise ApiResponse::InvalidParameter if discount <= 0

    transaction do
      promotion&.destroy # end any ongoing promotion
      p = Promotion.create(discount_type:, discount:, start_time:, end_time:, product: self)
    end
  end
end
