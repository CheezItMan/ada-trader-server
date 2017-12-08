class Stock < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true, length: {minimum: 2, maximum: 4}, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: true
end
