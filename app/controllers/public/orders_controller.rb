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
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @items = Item.all
    @total = 0
      @cart_items.each do |cart_item|
        @total += cart_item.subtotal
      end
    # binding.pry
    if @order.save
          @cart_items.each do |cart_item|
            @order_detail = OrderDetail.new
            @order_detail.item_id = @items.find_by(id: cart_item.item_id).id
            @order_detail.order_id = @order.id
            @order_detail.amount = cart_item.amount
            @order_detail.product_price = cart_item.subtotal
              if @order_detail.save
              else
                render :confirm
              end
          end
          @cart_items.destroy_all
          redirect_to orders_complete_path
    else
      render :confirm
    end
  end

  def complete
  end

  def index
    @orders = current_customer.orders
    @order_details = OrderDetail.where(order_id: @orders.pluck(:id))
    # @item_names = Item.where(id: @order_details.pluck(:item_id)).pluck(:name)
    @item_names = {}
    @order_details.each do |order_detail|
      items = Item.where(id: order_detail.item_id).pluck(:name)
      @item_names[order_detail.id] = items.join(",")
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :payment_method, :customer_id, :total_payment, :postage)
  end

end
