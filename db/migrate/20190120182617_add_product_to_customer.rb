class AddProductToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :product, foreign_key: true
  end
end
