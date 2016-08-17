class CreateCustomAddresses < ActiveRecord::Migration
  def change
    create_table :custom_addresses do |t|
      t.references :user, index: true, foreign_key: true
      t.string :address

      t.timestamps null: false
    end
  end
end
