class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
    	t.string :storage
      t.string :flag
      t.references :item, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
