class CreateQuickBloxes < ActiveRecord::Migration
  def change
    create_table :quick_bloxes do |t|
    	 t.references :user, index: true, foreign_key: true
       t.integer :qb_id
       t.string :qb_username
       t.string :qb_password

       t.timestamps null: false
    end
  end
end
