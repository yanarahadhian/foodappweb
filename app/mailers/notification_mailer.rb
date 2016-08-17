class NotificationMailer < ApplicationMailer
	default :from => "notification@joeyfoodapp.com"

	def notif_email(usermail, desc)
		@user_mail = usermail
		@body = desc
		mail(to: @user_mail,
				 subject: "Thank you for Joining us!")
  end
end