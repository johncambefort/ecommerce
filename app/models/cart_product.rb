class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def describe
    { product: product.describe, quantity: }
  end
end
