class Admin::SessionsController < Devise::SessionsController
	layout 'devise'
	def new
		super
	end

	def create
		super
	end

	def destroy
		super
	end

	protected

	def after_sign_in_path_for(resource)
		admin_index_path
	end

	def after_sign_out_path_for(resource)
		new_admin_session_path
	end

end