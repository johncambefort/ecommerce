# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def describe
    { id:, total:, discounted_total:, cart_products: cart_products.map(&:describe) }
  end

  def total
    return 0 if cart_products.empty?

    cart_products.reduce(0) { |sum, cp| sum + cp.product.price * cp.quantity }
  end

  def discounted_total
    # TODO: discounts
    total
  end
end
