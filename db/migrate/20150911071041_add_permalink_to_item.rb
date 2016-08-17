class AddPermalinkToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :permalink, :string
    add_index :items, :permalink
  end
  def self.down
    remove_column :items, :permalink
  end
end
