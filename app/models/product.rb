# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :carts, through: :cart_products
  has_many :cart_products

  def describe
    { id: id, name: name, brand: brand, price: price }
  end

  def buy(quantity, balance)
    new_balance = balance - (quantity * price)
    return unless new_balance.negative?

    raise Exception::NegativeBalanceException
  end
end
