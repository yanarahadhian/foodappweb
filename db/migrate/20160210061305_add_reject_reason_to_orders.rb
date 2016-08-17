class AddRejectReasonToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :reject_reason, :text
  end
end
