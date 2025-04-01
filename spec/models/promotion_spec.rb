require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'discounted_price' do
    let!(:product) { create(:product, price: 5) }
    it 'computes a flat fee discount' do
      promo = create(:promotion, product:, discount_type: :flat, discount: 2)
      expect(promo.discounted_price(promo.product.price, 1)).to eq(3)
    end

    it 'computes a flat fee discount given multiple items' do
      promo = create(:promotion, product:, discount_type: :flat, discount: 2)
      expect(promo.discounted_price(promo.product.price, 2)).to eq(6)
    end

    it 'computes a percentage fee discount' do
      promo = create(:promotion, product:, discount_type: :percentage, discount: 0.2)
      expect(promo.discounted_price(promo.product.price, 1)).to eq(4)
    end

    it 'computes a percentage fee discount given multiple items' do
      promo = create(:promotion, product:, discount_type: :percentage, discount: 0.2)
      expect(promo.discounted_price(promo.product.price, 4)).to eq(16)
    end

    it 'computes a b1g1free discount' do
      promo = create(:promotion, product:, discount_type: :b1g1free, discount: 1)
      expect(promo.discounted_price(promo.product.price, 2)).to eq(promo.product.price)
    end

    it 'computes a b1g1free discount given only 1 item' do
      promo = create(:promotion, product:, discount_type: :b1g1free, discount: 1)
      expect(promo.discounted_price(promo.product.price, 1)).to eq(promo.product.price)
    end

    it 'computes a b1g1free discount given 5 items; only 1 item gets the discount' do
      promo = create(:promotion, product:, discount_type: :b1g1free, discount: 1)
      expect(promo.discounted_price(promo.product.price, 5)).to eq(15)
    end

    it 'handles an unknown promotion type' do
      expect do
        create(:promotion, discount_type: :foo).discounted_price(1, 1)
      end.to raise_error(ArgumentError)
    end
  end
end
