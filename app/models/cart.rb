# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def describe
    { id:, cart_products: cart_products.map(&:describe) }
  end
end
