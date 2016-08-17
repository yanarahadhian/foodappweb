class AddColumnsToCustomAddresses < ActiveRecord::Migration
  def change
    add_column :custom_addresses, :recipient, :string
    add_column :custom_addresses, :name, :string
    add_column :custom_addresses, :state, :string
    add_column :custom_addresses, :city, :string
    add_column :custom_addresses, :postal, :string
    add_column :custom_addresses, :phone, :string
  end
end
