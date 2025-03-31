require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  path '/carts' do
    get 'Index carts' do
      produces 'application/json'

      response '200', 'show carts' do
        schema type: :array, items: { '$ref': '#/components/schemas/cart' }

        let!(:cart) { Cart.create }
        let!(:product) { create(:product, name: 'mangoes', price: 9.99, brand: 'Trader Joes') }
        let!(:cart_product) { CartProduct.create(cart:, product:, quantity: 5) }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Array)
          expect(data.size).to eq(1)
          expect(data[0]).to eq({ 'id' => cart.id,
                                  'total' => cart.total,
                                  'discounted_total' => cart.discounted_total,
                                  'cart_products' => [
                                    {
                                      'product' => {
                                        'name' => product.name,
                                        'brand' => product.brand,
                                        'id' => product.id,
                                        'price' => product.price
                                      },
                                      'quantity' => cart_product.quantity
                                    }
                                  ] })
        end
      end
    end
  end

  path '/carts/{id}' do
    get 'Show cart' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'show cart' do
        schema '$ref' => '#/components/schemas/cart'

        let!(:cart) { Cart.create }
        let!(:product) { create(:product, name: 'mangoes', price: 9.99, brand: 'Trader Joes') }
        let!(:cart_product) { CartProduct.create(cart:, product:, quantity: 5) }
        let!(:id) { cart.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({ 'id' => cart.id,
                               'total' => cart.total,
                               'discounted_total' => cart.discounted_total,
                               'cart_products' => [
                                 {
                                   'product' => {
                                     'name' => product.name,
                                     'brand' => product.brand,
                                     'id' => product.id,
                                     'price' => product.price
                                   },
                                   'quantity' => cart_product.quantity
                                 }
                               ] })
        end
      end

      response '404', 'cart not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
