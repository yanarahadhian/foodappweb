class Admin::PaymentsController < Admin::AdminsController
	layout 'admin'
  def index
    @trans = Payment.all
  end

  def new
    @trans = Payment.new
  end

  def edit
    @trans = Payment.find_by_id(params[:id])
  end

  def show
    @trans = Payment.find_by_id(params[:id])
  end

  def create
      @trans = Payment.new(params_payment)
      if @trans.save
          flash[:notice] = "Success Add Records"
          redirect_to action: 'index'
      else
          flash[:error] = "data not valid"
          render 'new'
      end
  end
  def update
    @trans = Payment.find_by_id(params[:id])
    if @trans.update(params_payment)
      flash[:notice] = "Success Update Records"
      redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    @trans = Payment.find_by_id(params[:id])
    if @trans.destroy
        flash[:notice] = "Success Delete a Records"
        redirect_to action: 'index'
    else
        flash[:error] = "fails delete a records"
        redirect_to action: 'index'
    end
  end

  private
    def params_payment
        params.require(:trans).permit(:cart_id, :user_id, :sub_total, :email, :password)
    end

end
