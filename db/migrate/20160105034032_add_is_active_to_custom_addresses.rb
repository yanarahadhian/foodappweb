class AddIsActiveToCustomAddresses < ActiveRecord::Migration
  def change
    add_column :custom_addresses, :is_active, :boolean
  end
end
