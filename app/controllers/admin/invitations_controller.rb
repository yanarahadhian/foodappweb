class Admin::InvitationsController < Admin::AdminsController
	layout 'admin'
	def index
    @state = "DESC"
    @invites = Invitation.all
	  @invite = Invitation.order("created_at DESC").page(params[:page]).per(25)
	end

	def send_mail
		@admin_mail = Invitation.admin_invitation_mail(params)
		redirect_to admin_invitations_path
	end

	def filter_invite
    @state = params[:sort_filter]
 	  @sort = params[:keyword].nil? ? "created_at" : "#{params[:keyword]}"
  	@invite = Invitation.filter(params, @state, @sort)
	end

	def option_invite	
 	  @sort = params[:keyword].nil? ? "created_at" : "#{params[:keyword]}"
  	@invite = Invitation.filter(params, params[:sort_filter], @sort)
	end

  def sort_data
    @state = params[:state] == "ASC" ? "DESC" : "ASC"
    @sort = params[:keyword].nil? ? "id" : "#{params[:keyword]}"
    @invite = Invitation.filter(params, @state, @sort)
  end

	def sort_column
    Invitation.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def destroy
    @invite = Invitation.find(params[:id])
    if @invite.destroy
        flash[:notice] = "Success Delete a Records"
        redirect_to action: 'index'
    else
        flash[:error] = "Failed delete a records"
        redirect_to action: 'index'
    end
  end

  def destroy_multiple
  	if !params[:tag].blank?
  		Invitation.where("id IN (#{params[:tag].collect {|k,v| k }.join(",")})").destroy_all
  	end
  	respond_to do |format|
	  	format.html { redirect_to admin_invitations_path }
	  end
  end
end