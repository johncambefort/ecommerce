require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.create }

  describe 'total' do
    it 'returns 0 if the cart is empty' do
      cart.cart_products = []
      expect(cart.total).to eq(0)
    end

    it 'returns the sum of the cart products prices multiplied by the quantity' do
      cart_product_one = CartProduct.create(cart:, quantity: 2, product: create(:product, price: 5))
      cart_product_two = CartProduct.create(cart:, quantity: 1, product: create(:product, price: 3.99))
      cart.cart_products = [cart_product_one, cart_product_two]
      expect(cart.total).to eq(13.99)
    end
  end
end
