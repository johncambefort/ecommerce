require 'swagger_helper'

RSpec.describe 'Products', type: :request do
  path '/products' do
    get 'Show first ten products' do
      produces 'application/json'

      response '200', 'products shown' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :number, example: 1 },
                   name: { type: :string, example: 'apples' },
                   price: { type: :number, format: :float, example: 2.99 }
                 }
               },
               required: %w[id name price]

        let!(:product) { Product.create(name: 'mangoes', price: 9.99) }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_an(Array)
          expect(data.size).to be > 0
          expect(data[0]['id']).to eq(product.id)
          expect(data[0]['name']).to eq(product.name)
          expect(data[0]['price']).to eq(product.price)
        end
      end
    end
  end
end
