# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :carts, through: :cart_products
  has_many :cart_products
  has_one :promotion

  def describe
    { id:, name:, brand:, price: }
  end

  def create_promotion(_discount_type, _discount, _start_time, _end_time)
    raise ApiResponse::InvalidParameter if discount_type == :percentage && (discount.negative? || discount > 1)

    promotion = nil

    transaction do
      promotion&.destroy # end any ongoing promotion
      promotion = Promotion.create(discount_type: discount_type.to_sym, discount:, start_time:, end_time:)
    end

    promotion
  end
end
