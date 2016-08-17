class CreateReports < ActiveRecord::Migration
  def change
	  create_table :reports do |t|
	    t.references :report_type, index: true, foreign_key: true
	    t.string :comment
	    t.references :report, index: true, polymorphic: true

	    t.timestamps null: false
	  end
  end
end