class Report < ActiveRecord::Base
	belongs_to :reporter, :foreign_key => 'reporter_integer', :class_name => 'User'
 	belongs_to :report_category, :foreign_key => 'report_type_id', :class_name => 'ReportType'
 	belongs_to :report, :polymorphic => true
 	
end
