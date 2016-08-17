class Admin::ItemCategoriesController < Admin::AdminsController
  layout 'admin'
	def index
		@category = ItemCategory.order("name").page(params[:page]).per(25)
	end

	def new
		@category = ItemCategory.new		
	end

	def edit
    @category = ItemCategory.find_by_id(params[:id])
  end

  def create
      @category = ItemCategory.new(params_category)
      if @category.save
          flash[:notice] = "Success Add Records"
          redirect_to action: 'index'
      else
          flash[:error] = "data not valid"
          render 'new'
      end
  end
  def update
    @category = ItemCategory.find_by_id(params[:id])
    if @category.update(params_category)
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    @category = ItemCategory.find_by_id(params[:id])
    if @category.items.count == 0 
    		@category.destroy
        flash[:notice] = "Success Delete a Records"
        redirect_to action: 'index'
    else
        flash[:error] = "can't delete a records has items"
        redirect_to action: 'index'
    end
  end

  private    
    def params_category
        params.require(:item_category).permit(:name)
    end
end
