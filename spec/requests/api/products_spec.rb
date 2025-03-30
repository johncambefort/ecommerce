require 'swagger_helper'

RSpec.describe 'Products', type: :request do
  path '/products' do
    get 'Index products' do
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
end
