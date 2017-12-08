class Stock < ApplicationRecord
  validates :symbol, presence: true, length: {minimum: 2, maximum: 4}, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: true
end
