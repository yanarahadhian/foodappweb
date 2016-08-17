class InvitationsController < ApplicationController
  layout 'application'
  skip_before_action :authenticate_admin!
  skip_before_action :verify_authenticity_token
  include ApplicationHelper

  def index
  end

  def landing
  	@invitation = Invitation.new
    if !params[:f].blank?
      if params[:f] == "reserve_uname"
        @notif = "success"
      end
    end
  end

  def create
    @ref_id = Invitation.find_by_ref_id(params[:invitation][:ref_id])
    if @ref_id.nil?
      @invitation = Invitation.new(params_invitation)
    else
      @invitation = @ref_id.childrens.build(params_invitation)
    end
    @invitation.country = visitor_country
    if @invitation.save
      if @invitation.present?
        InvitationMailer.invite_email(@invitation).deliver_now
        flash[:notice] = "Registration Successful. #{@invitation.email} has been added to our database. Thank you!"
      else
        flash[:notice] = "Invitation Failed!"
      end
        render 'invite_friend'
    else
        flash[:notice] = "Email has already been taken!!"
        flash[:error] = "data not valid"
        render 'landing'
    end
  end

  def invitation_username
    @invitation = Invitation.find(params[:id])
    @invitation.username = params[:invitation][:username]
    respond_to do |f|
      if @invitation.save
        InvitationMailer.mail_booked_username(@invitation).deliver_now
        flash[:notice] = "Username #{@invitation.username} reserved"
        @notif = "success"
      end
      f.js
    end
  end

  def invited_username
    @user_names = Invitation.get_invited_records
    render json: @user_names
  end

  def mail_invite
    @invitation = Invitation.find(params[:invitation])
    @invitation.notes = params[:notes]
    InvitationMailer.mail_invite(params[:mail_to], params[:notes], @invitation).deliver_now
    flash[:notice] = "Invites sent. You're a trooper!"
    render 'invite_username'
    @notif = "success"
  end

  def invite_username
    @invitation = Invitation.find(params[:id])
    # render layout: false
  end

  def valid_user
    sample_username = File.open(Rails.root.to_s+"/sample_username.txt", "rb").read.split("\n")
    if sample_username.include?(params[:username])
      @msg = {:message => "Already taken", :status => "existed"}
    else
      if params[:username].to_s.downcase.match(/tuckerbox/).present?
          @msg = {:message => "Can’t use this username", :status => "existed"}
      else
        valid_invite = Invitation.where("username LIKE ?", "%#{params[:username]}%")
        valid_user = User.where("username LIKE ?", "%#{params[:username]}%")
        if valid_invite.present? || valid_user.present?
          @msg = {:message => "Already taken", :status => "existed"}
        else
          @msg = {:message => "Available", :status => "available" }
        end
      end
    end
    render :layout => false, :json => @msg, :status => @status
  end

  def privacy
    
  end

  def terms
    
  end

  def show
    @invitation = Invitation.find(params[:id])
    render 'invite_friend'
  end

  private
  def params_invitation
    params.require(:invitation).permit(:first_name, :country, :email, :status, :ref_id, :username, :inviter_id)
  end

end
