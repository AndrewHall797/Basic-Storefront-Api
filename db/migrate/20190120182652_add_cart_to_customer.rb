class AddCartToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :cart, foreign_key: true
  end
end
