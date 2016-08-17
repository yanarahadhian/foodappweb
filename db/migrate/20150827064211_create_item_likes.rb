class CreateItemLikes < ActiveRecord::Migration
  def change
    create_table :item_likes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
