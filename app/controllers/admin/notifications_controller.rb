class Admin::NotificationsController < Admin::AdminsController
  layout 'admin'
  require 'parse-ruby-client'
  def index
  	@notifs = Notification.order("created_at desc").page(params[:page]).per(25)
  	@notif = Notification.new
  end

  def edit
  	@notif = Notification.find_by_id(params[:id])
  	respond_to do |f|
  		f.js
  	end
  end

  def new
  	@notif = Notification.new
  	respond_to do |f|
  		f.js
  	end
  end

  def create
  	@notif = Notification.new(params_notif)
  	if @notif.save
      if @notif.present?
        @notif.notif_parse(params)
      end
      redirect_to admin_notifications_path
    else
      flash[:error] = "Data not valid!!"
      redirect_to admin_notifications_path
    end
  end

  def update
  	@notif = Notification.find_by_id(params[:id])
  	if @notif.update(params_notif)
      if @notif.present?
        @notif.notif_parse(params)
      end
      redirect_to admin_notifications_path
    else
      redirect_to admin_notifications_path
    end
  end

  def destroy
  	@notif = Notification.find_by_id(params[:id])
    if @notif.destroy
        flash[:notice] = "Success Delete a Records"
        redirect_to admin_notifications_path
    else
        flash[:error] = "fails delete a records"
        redirect_to admin_notifications_path
    end
  end

  private

  def params_notif
    params.require(:notification).permit(:notif_date, :description)
  end

end
