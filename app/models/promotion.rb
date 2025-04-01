# frozen_string_literal: true

class Promotion < ApplicationRecord
  belongs_to :product
  enum :discount_type, { flat: 0, percentage: 1, b1g1free: 2 }

  def discounted_price(price_for_one, quantity)
    total_price = price_for_one * quantity

    case discount_type.to_sym
    when :flat
      total_price - (quantity * discount)
    when :percentage
      (total_price - (total_price * discount)).round(2)
    when :b1g1free
      total_price - (price_for_one * (quantity / 2))
    end
  end

  def running
    self if start_time < Time.zone.now && Time.zone.now < end_time
  end
end
