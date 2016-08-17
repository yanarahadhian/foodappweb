class Admin::ReportsController < ApplicationController
	layout 'admin'
  def items
    @item = Item.where.not(:status => "active").page(params[:page]).per(25)
  end

  def users
    @user = User.where.not(:status => "active").page(params[:page]).per(25)
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def edit_item
    @item = Item.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    @user.update_attribute(:status, params[:status])
    @user.reports.last.update_attribute(:reason, params[:reason])
  end

  def update_item
    @item = Item.find(params[:id])
    @item.update_attribute(:status, params[:status])
    @item.reports.last.update_attribute(:reason, params[:reason])
  end

  def user_mail
    @user = User.find(params[:id])
    ReportMailer.user_email(@user).deliver_now
    redirect_to admin_reports_users_path
  end

  def item_mail
    @item = Item.find(params[:id])
    ReportMailer.item_email(@item).deliver_now
    redirect_to admin_reports_items_path
  end

  def filter_user
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @user = User.filter(params, @state, @sort).where.not(:status => "active")
  end

  def option_user
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @user = User.filter(params, @state, @sort)
  end

  def filter_item
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @item = Item.filter(params, @state, @sort).where.not(:status => "active")
  end

  def option_item
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @users = Item.filter(params, @state, @sort)
  end

  def delete_user
    @user = User.find(params[:id])
    if @user.present?
      @user.destroy
      flash[:notice] = "Success Delete a Records"
      redirect_to admin_reports_users_path
    end
  end

  def delete_item
    @item = Item.find(params[:id])
    if @item.present?
      @item.destroy
      flash[:notice] = "Success Delete a Records"
      redirect_to admin_reports_items_path
    end
  end
end
