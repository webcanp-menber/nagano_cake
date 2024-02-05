class Public::OrdersController < ApplicationController

  def new
    @customer = Customer.find(current_customer.id)
    @order = Order.new
    @total = 0
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def confirm
    @order = Order.new(order_params)
    @items = Item.all
    @total = 0
    @cart_items = CartItem.where(customer_id: current_customer.id)
    if params[:order][:select_address] == "address"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

  def create
    @order = Order.new(order_params)
    @customer = Customer.find(current_customer.id)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @items = Item.all
    @total = 0
     @cart_items.each do |cart_item|
       @total += cart_item.subtotal
     end
    # binding.pry
    if @order.save
      redirect_to orders_complete_path
    else
      render :confirm
    end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method, :customers_id, :total_payment, :postage)
  end

end
