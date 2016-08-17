class InvitationMailer < ApplicationMailer
	default :from => "do-not-reply@tuckerbox.es"

	def invite_email(invitation)
		@invite = invitation
		attachments["tuckbox_logo.png"] = File.read("#{Rails.root}/app/assets/images/tuckbox_logo.png")
		mail(to: @invite.email,
				 subject: "Invitation to join TuckerBox") do |format|
        	format.html { render 'invite_email'}
         end
  end

  def admin_email_invitation(usermail, sbj, desc)
  	@user_mail = usermail
  	@submail = sbj
  	@body = desc
  	mail(to: @user_mail, subject: sbj)
  end

  def mail_invite(usermail, desc, invitation)
    attachments["fb.png"] = File.read("#{Rails.root}/app/assets/images/fb.png")
    attachments["twit.png"] = File.read("#{Rails.root}/app/assets/images/twit.png")
    attachments["ig.png"] = File.read("#{Rails.root}/app/assets/images/ig.png")
    attachments["tuckbox_logo.png"] = File.read("#{Rails.root}/app/assets/images/tuckbox_logo.png")
  	@user_mail = usermail
  	@body = desc
    @invitation = invitation
  	mail(to: @user_mail, subject: "Invitation to join TuckerBox")
  end

  def mail_booked_username(invitation)
    @invite = invitation
    attachments["fb.png"] = File.read("#{Rails.root}/app/assets/images/fb.png")
    attachments["twit.png"] = File.read("#{Rails.root}/app/assets/images/twit.png")
    attachments["ig.png"] = File.read("#{Rails.root}/app/assets/images/ig.png")
    attachments["tuckbox_logo.png"] = File.read("#{Rails.root}/app/assets/images/tuckbox_logo.png")
    mail(to: invitation.email, subject: "Username Reserved") do |format|
      format.html { render 'mail_booked_username'}
    end
  end
end
