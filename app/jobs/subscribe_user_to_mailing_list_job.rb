class SubscribeUserToMailingListJob < ActiveJob::Base
  queue_as :default

  def perform(emails)
    gb = Gibbon::Request.new
    gb.lists.subscribe({:id => "059b2694a2", :email => {:email => 'yana.rahadhian@cgw.co.id'}, :double_optin => false})
  end
end
