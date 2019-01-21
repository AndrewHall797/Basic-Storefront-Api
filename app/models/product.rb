class Product < ApplicationRecord
    validates_uniqueness_of :name
    has_many :customers
    has_many :carts, through: :customers 
end
