class Notification < ActiveRecord::Base
	before_save :send_time
	def admin_notification_mail(params)
  	# send_mail = SubscribeUserToMailingListJob.perform_later('yana.rahadhian@wgs.co.id')
  	user_mail = User.all.pluck(:email)
  	user_mail.each do |nm|
  		self.notif_date = self.notif_date.advance(seconds: 10)
			notif_mailer = NotificationMailer.delay(run_at: self.notif_date).notif_email(nm, params[:message])
		end
  end

  def send_time
  	_time = Time.now.strftime("%H:%M:%S")
  	self.notif_date = (self.notif_date.to_datetime + Time.parse("#{_time}").seconds_since_midnight.seconds).advance(:hours => -7)
  end

  def notif_parse(params)
    parse_object = $parse_client.object("Nofification")
    parse_object["description"] = self.description
    result = parse_object.save
  end
end
