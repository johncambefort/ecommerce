require 'swagger_helper'

RSpec.describe 'Products', type: :request do
  path '/products' do
    get 'Index products' do
      tags 'Products'
      produces 'application/json'

      response '200', 'show products' do
        schema type: :array,
               items: { '$ref': '#/components/schemas/product' }

        let!(:product) { Product.create(name: 'mangoes', price: 9.99, brand: 'Trader Joes') }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Array)
          expect(data.size).to eq(1)
          expect(data.first['id']).to eq(product.id)
          expect(data.first['name']).to eq(product.name)
          expect(data.first['brand']).to eq(product.brand)
          expect(data.first['price']).to eq(product.price)
        end
      end
    end
  end

  path '/products/{id}' do
    get 'Show product' do
      tags 'Products'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'show product' do
        schema '$ref' => '#/components/schemas/product'

        let!(:product) { Product.create(name: 'mangoes', price: 9.99) }
        let(:id) { product.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['id']).to eq(product.id)
          expect(data['name']).to eq(product.name)
          expect(data['brand']).to eq(product.brand)
          expect(data['price']).to eq(product.price)
        end
      end

      response '404', 'product not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/products/{id}/create_promotion' do
    post 'Create a promotion' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :promotion_params, in: :body, schema: {
        type: :object,
        properties: {
          discount: { type: :float, example: 1 },
          discount_type: { type: :string, enum: %w[flat percentage b1g1free], example: :flat },
          start_time: { type: :datetime, example: '2025-02-01T02:05:38+00:00' },
          end_time: { type: :datetime, example: '2026-03-02T02:05:38+00:00' }
        },
        required: %w[discount_type discount start_time end_time]
      }

      response '200', 'creates the promotion' do
        let(:cart) { Cart.create }
        let(:start_time) { (Time.zone.now - 1.day).to_datetime.to_s }
        let(:end_time) { (Time.zone.now + 1.day).to_datetime.to_s }
        let(:product) { create(:product, price: 5) }
        let(:promotion_params) { { discount: 1, discount_type: :flat, start_time:, end_time: } }
        let(:id) { product.id }

        run_test! do
          expect(Promotion.count).to eq(1)
          cart.add_product(product, 1)
          expect(cart.discounted_total).to eq(4)
        end
      end
    end
  end
end
