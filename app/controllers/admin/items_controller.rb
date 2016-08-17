class Admin::ItemsController < Admin::AdminsController
	layout 'admin'
  def index
    # @items = Item.all
    #@user_by_item = User.find_by_id(@items.user_id)
    @items = Item.order(:created_at).page(params[:page]).per(25)
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find_by_id(params[:id])
  end

  def show
    @item = Item.find_by_id(params[:id])
  end

  def create
      @item = Item.new(params_item)
      if @item.save
          flash[:notice] = "Success Add Records"
          redirect_to action: 'index'
      else
          flash[:error] = "data not valid"
          render 'new'
      end
  end
  def update
    @item = Item.find(params[:id])
    if @item.update(params_item)
      arr_image_id = []
      if params[:image]
        if @item.images.present?
          @item.destroy_images(params[:image_detail])
        end
        params[:image].each {|image| 
          @item.images.create(storage: image, flag: "item")
        }        
      end
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    if @item.destroy
        flash[:notice] = "Success Delete a Records"
        redirect_to action: 'index'
    else
        flash[:error] = "fails delete a records"
        redirect_to action: 'index'
    end
  end

  def filter_item
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @items = Item.filter(params, @state, @sort)
  end

  def option_item
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @items = Item.filter(params, @state, @sort)
  end

  def user_items
    user = User.find(params[:id])
    @items = user.items.page(params[:page]).per(25)
    render "index"
  end

  private
    def params_item
        params.require(:item).permit(:user_id, :category_id, :name, :photo, :price, :liked, :description)
    end

end
