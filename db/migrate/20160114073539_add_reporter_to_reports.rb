class AddReporterToReports < ActiveRecord::Migration
  def change
    add_column :reports, :reporter_integer, :string
  end
end
