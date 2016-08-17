class CreateOrdersPayments < ActiveRecord::Migration
  def change
    create_table :orders_payments do |t|
      t.references :order, index: true, foreign_key: true
      t.references :payment, index: true, foreign_key: true
    end
  end
end
