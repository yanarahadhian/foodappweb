class Admin::ImagesController < Admin::AdminsController
	layout 'admin'
	def create
		@image = Image.new(image_params)
		@image.save
	end

	def destroy
		@image = Image.find_by_id(params[:id])
		@image_item = @image.item
		if @image.destroy
        flash[:notice] = "Success Delete a Records"
        redirect_to edit_admin_item_path(@image.item.id)
    else
        flash[:error] = "fails delete a records"
        redirect_to :controller => 'items', :action => 'edit', :id => @image_item
    end
	end
end