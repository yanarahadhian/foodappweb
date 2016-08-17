class AddLikeCountToItems < ActiveRecord::Migration
  def change
  	add_column :items, :like_count, :integer, :default => 0
  end
end
