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

  describe 'add_product' do
    it 'creates a CartProduct with the product and quantity' do
      product = create(:product)
      cart.add_product(product, 2)

      expect(cart.total).to eq(product.price * 2)
      expect(cart.cart_products.size).to eq(1)
      expect(cart.products.size).to eq(1)
      expect(CartProduct.last.product).to eq(product)
      expect(CartProduct.last.quantity).to eq(2)
    end

    it 'does not add the product if it does not exist' do
      expect { cart.add_product(nil, 1) }.to raise_error(Exceptions::ProductNilException)
      expect(cart.cart_products.count).to eq(0)
    end

    it 'does not add the product if the quantity is negative' do
      product = create(:product)
      cart.add_product(product, -1)
      expect(cart.cart_products).to be_empty
      expect(cart.products).to be_empty
    end
  end

  describe 'remove_product' do
    let!(:cart_product_one) { CartProduct.create(cart:, quantity: 3, product: create(:product, price: 5)) }
    let!(:cart_product_two) { CartProduct.create(cart:, quantity: 1, product: create(:product, price: 3.99)) }

    it 'destroys a CartProduct if new quantity is zero' do
      expect { cart.remove_product(cart_product_one.product, 3) }.to change { CartProduct.count }.by(-1)
      expect { cart_product_one.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(cart.cart_products.size).to eq(1)
      expect(cart.cart_products).to eq([cart_product_two])
      expect(cart.total).to eq(3.99)
    end

    it 'does nothing if the product is nil' do
      expect { cart.remove_product(nil, 1) }.to raise_error(Exceptions::ProductNilException)
      expect(cart.cart_products.count).to eq(2)
    end

    it 'updates the CartProduct quantity without destroying it' do
      expect { cart.remove_product(cart_product_one.product, 2) }.to change { CartProduct.count }.by(0)
      expect(cart.cart_products.size).to eq(2)
      expect(cart.total).to eq(5 + 3.99)
    end
  end
end
