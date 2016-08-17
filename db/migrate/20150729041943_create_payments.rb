class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.integer 	:cart_id
    	t.integer 	:user_id
    	t.integer 	:number_of_items
    	t.decimal 	:sub_total
    	t.decimal 	:vat_total
    	t.decimal 	:total
    	t.date			:payment_date
    	t.string		:status
    	t.integer 	:reference_id
    	t.string		:currency

    	t.timestamps
    end
  end
end
