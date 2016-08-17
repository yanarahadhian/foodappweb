class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.datetime	:notif_date
    	t.text	:description

      t.timestamps null: false
    end
  end
end
