class CreateItemPhotos < ActiveRecord::Migration
  def change
    create_table :item_photos do |t|
    	t.integer 	:user_id
    	t.integer 	:item_id
    	t.integer 	:position
    	t.string 		:url
    	
    	t.timestamps
    end
  end
end
