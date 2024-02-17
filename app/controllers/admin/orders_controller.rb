class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

def show
  @order = Order.find(params[:id])
  @order_details = OrderDetail.where(order_id: @order.id)
  @selected_status = @order.status
end

def status_i18n
  I18n.t("enums.order.status.#{status}")
end

def update
  @order = Order.find(params[:id])
  if @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  else
    redirect_to admin_order_path(@order.id)
  end
end


private

def order_params
  params.require(:order).permit(:status).merge(status: params[:order][:status].to_i)
end

end
