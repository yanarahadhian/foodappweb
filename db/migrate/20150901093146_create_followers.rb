class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
    	t.integer :user_id
    	t.integer :user_follower_id
    end
  end
end
