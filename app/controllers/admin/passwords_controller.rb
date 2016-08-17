class Admin::PasswordsController < Devise::PasswordsController
	layout 'devise'
	def new
		super
	end

	def create
		super
	end

	def edit
		super
	end

	protected

  def after_sending_reset_password_instructions_path_for(resource)
    new_admin_session_path
  end

end