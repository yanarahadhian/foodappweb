class Admin::AdminsController < ApplicationController
	layout 'admin'
	def index
		@users = User.all
		@items = Item.all
		
		@pending_order = Payment.all.where(status: "Pending")
		@completed_order = Payment.all.where(status: "Completed")
		@canceled_order = Payment.all.where(status: "Canceled")
		@confirmed_order = Payment.all.where(status: "Confirmed")
		@shipped_order = Payment.all.where(status: "Shipped")
	end
end
