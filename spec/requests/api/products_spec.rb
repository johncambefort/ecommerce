require 'swagger_helper'

RSpec.describe 'Products', type: :request do
  path '/products' do
    get 'Show first ten products' do
      produces 'application/json'

      response '200', 'products shown' do
        schema type: :object,
               properties: {
                 id: { type: :integer, example: 1 },
                 name: { type: :string, example: 'apples' },
                 price: { type: :number, format: :float, example: 2.99 }
               },
               required: %w[id name price]

        let(:product) { Product.create(name: 'mangoes', price: 9.99) }
        run_test! do |response|
          data = JSON.parse(response.body)
          puts data
          expect(data['id']).to eq(product.id)
          expect(data['name']).to eq('mangoe')
          expect(data['price']).to eq(9.99)
        end
      end
    end
  end
end
