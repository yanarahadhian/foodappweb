# include SmartListing::Helper::ControllerExtensions
# helper  SmartListing::Helper

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_admin!
  before_filter :configure_devise_param, if: :devise_controller?

  layout :determine_layout
  def determine_layout
    devise_controller? ? 'devise' : 'application'
  end

  protected
  	def configure_devise_param
  		devise_parameter_sanitizer.for(:sign_up).concat([:full_name])
  	end
end
