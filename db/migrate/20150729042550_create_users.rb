class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string 		:full_name
    	t.string 		:email
    	t.string 		:password_digest
      t.string    :access_token
      t.datetime  :token_generated_at
      t.text      :settings
      t.string    :facebook_id
      t.string    :verified_fb
      t.string    :country
      t.integer   :city
      t.string    :website_url
    	t.text 			:about_me    	

    	t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, :access_token, :unique => true
  end
end
