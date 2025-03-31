# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  def describe
    { id:, total:, discounted_total:, cart_products: cart_products.map(&:describe) }
  end

  def total
    return 0 if cart_products.empty?

    cart_products.reduce(0) { |sum, cart_product| sum + cart_product.product.price * cart_product.quantity }
  end

  def discounted_total
    # TODO: discounts
    total
  end

  def add_product(product, quantity)
    raise Exceptions::ProductNilException, 'Product cannot be nil!' if product.nil?

    CartProduct.create(cart: self, product:, quantity:) unless quantity <= 0
  end

  def remove_product(product, quantity)
    cart_product = CartProduct.find_by(product:)
    raise Exceptions::ProductNilException, 'Product cannot be nil!' if cart_product.nil?

    if cart_product.quantity - quantity <= 0
      cart_product.destroy
    else
      cart_product.quantity -= quantity
      cart_product.save!
    end
  end
end
