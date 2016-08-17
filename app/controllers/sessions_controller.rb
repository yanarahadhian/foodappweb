class SessionsController < Devise::SessionsController

  def create
    # add custom logic here
    #redirect_to admins_index 
    super
  end

end 