require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'discounted_price' do
    let!(:product) { create(:product, price: 5) }
    it 'computes a flat fee discount' do
      promo = create(:promotion, product:, discount_type: :flat, discount: 2)
      expect(promo.discounted_price(promo.product.price, 1)).to eq(3)
    end

    it 'computes a flat fee discount with multiple items' do
      promo = create(:promotion, product:, discount_type: :flat, discount: 2)
      expect(promo.discounted_price(promo.product.price, 2)).to eq(6)
    end
  end
end
