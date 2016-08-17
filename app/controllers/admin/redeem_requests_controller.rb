class Admin::RedeemRequestsController < ApplicationController
	layout 'admin'
  def index
  	@redeem = RedeemRequest.where.not(:status => 1 ).page(params[:page]).per(25)
  end

  def edit
    @redeem = RedeemRequest.find(params[:id])
  end

  def update
  	@redeem = RedeemRequest.find(params[:id])
  	@redeem.update_attribute(:status, params[:status].to_i)
  end

  def filter_redeem
    @state = params[:sort_filter]
 	  @sort = params[:keyword].nil? ? "created_at" : "#{params[:keyword]}"
  	@redeem = RedeemRequest.filter(params, @state, @sort)
	end

	def option_redeem
 	  @sort = params[:keyword].nil? ? "created_at" : "#{params[:keyword]}"
  	@invite = RedeemRequest.filter(params, params[:sort_filter], @sort)
	end
end
