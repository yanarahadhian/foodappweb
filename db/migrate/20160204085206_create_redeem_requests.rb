class CreateRedeemRequests < ActiveRecord::Migration
  def change
    create_table :redeem_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :amount
      t.integer :status

      t.timestamps null: false
    end
  end
end
