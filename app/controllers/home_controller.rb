class HomeController < ApplicationController
	skip_before_action :authenticate_admin!
	
  def show
  	user_permalink = params[:permalink]	
  	@user = User.find_by permalink: user_permalink	
	  if @user.blank?
	  	redirect_to root_path
	  else
	  	@items = @user.items.order(:created_at).page(params[:page]).per(3)
	  	respond_to do |format|
		  	format.html
		  	format.js
		  end
	  end
	end

	def detail
		user_permalink = params[:permalink]
		item_permalink = params[:item_permalink]
		@user = User.find_by permalink: user_permalink
		if @user.present?
			@item = @user.items.find_by permalink: item_permalink
		end

		if @item.blank?
			redirect_to action: :show
		end
	end

	def reset_password
		@user = User.find_by_id(params[:moch])
		if @user.is_reset_token_valid?(params[:qwi])
		else
			flash[:notice] = "Sorry Your Token is Invalid!!"
			redirect_to root_path
		end
	end

	def update_password
		@user = User.find(params[:moch])
		unless @user.nil?
			@user.update_attributes(user_params)
      flash[:notice] = "Success Update Records"
      redirect_to root_path
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
	end

	private

	def user_params
		params.require(:user).permit(:password)
	end

end
