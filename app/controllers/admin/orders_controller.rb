class Admin::OrdersController < Admin::AdminsController
  layout 'admin'
	def index
    @order = Order.order("created_at").page(params[:page]).per(25)
  end

  def filter_order
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @order = Order.filter(params, @state, @sort)
  end

  def option_order
    @sort = params[:keyword].nil? ? "id":"#{params[:keyword]}"
    @order = Order.filter(params, @state, @sort)
  end

  def user_orders
  	user = User.find(params[:id])
  	@order = user.orders.page(params[:page]).per(25)
  	render 'index'
  end
end
