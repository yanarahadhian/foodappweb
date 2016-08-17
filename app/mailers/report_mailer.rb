class ReportMailer < ApplicationMailer
	default :from => "do-not-reply@tuckerbox.es"

  def user_email(user)
    @user = user
    attachments["tuckbox_logo.png"] = File.read("#{Rails.root}/app/assets/images/tuckbox_logo.png")
    mail(to: @user.email,
         subject: "Report User TuckerBox") do |format|
          format.html { render 'user_mail'}
         end
  end

  def item_email(item)
    @item = item
    attachments["tuckbox_logo.png"] = File.read("#{Rails.root}/app/assets/images/tuckbox_logo.png")
    mail(to: @item.user.email,
         subject: "Report Item TuckerBox") do |format|
          format.html { render 'item_mail'}
         end
  end
end
