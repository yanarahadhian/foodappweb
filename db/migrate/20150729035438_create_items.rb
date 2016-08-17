class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :user_id
      t.integer :item_category_id
      t.string :name
      t.float :delivery_fee
      t.float :price
      t.text :description

    	t.timestamps null: false
    end
  end
end
