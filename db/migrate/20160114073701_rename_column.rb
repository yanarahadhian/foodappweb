class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :report_types, :type, :name
  end
end
