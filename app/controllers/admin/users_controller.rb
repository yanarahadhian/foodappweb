class Admin::UsersController < Admin::AdminsController
  layout 'admin'
  def index
    if params[:follow_type].present? and params[:follow_type] == "follower"
      @user = User.find_by_id(params[:id])
      @users = Kaminari.paginate_array(@user.followers(order: "users.full_name", joins: "LEFT JOIN users ON users.id = followable_id")).page(params[:page]).per(25)
    elsif params[:follow_type].present? and params[:follow_type] == "following"
      @user = User.find_by_id(params[:id])
      @users = Kaminari.paginate_array(@user.all_following(order: "users.full_name", joins: "LEFT JOIN users ON users.id = followable_id")).page(params[:page]).per(25)
    else
      @users = User.order(:full_name).page params[:page]
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def create
      @user = User.new(params_user)
      if @user.save
          flash[:notice] = "Success Add Records"
          redirect_to action: 'index'
      else
          flash[:error] = "data not valid"
          render 'new'
      end
  end
  def update
    @user = User.find_by_id(params[:id])
    if @user.update(params_user)
      if params[:avatar]
        @user.avatar = params[:avatar]
      end
      if params[:background]
        @user.background = params[:background]      
      end
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user.destroy
        flash[:notice] = "Success Delete a Records"
        redirect_to action: 'index'
    else
        flash[:error] = "fails delete a records"
        redirect_to action: 'index'
    end
  end

  def filter_user
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @users = User.filter(params, @state, @sort)
  end

  def option_user
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @users = User.filter(params, @state, @sort)
  end

  private
    def password_provided?
      
    end
    
    def params_user
        params.require(:user).permit(
          :full_name, 
          :email, 
          :password_digest, 
          :access_token, 
          :token_generate_at, 
          :settings,
          :facebook_id,
          :verified_fb,
          :country,
          :city,
          :website_url,
          :about_me,
          :google_id,
          :verified_gplus,
          :phone,
          :avatar
        )
    end

end
