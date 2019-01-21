class Cart < ApplicationRecord
    validates_uniqueness_of :name
    has_many :customers
    has_many :products, through: :customers
end
