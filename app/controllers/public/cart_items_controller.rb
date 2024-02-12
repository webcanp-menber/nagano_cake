class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

def create
  @cart_item = CartItem.new(cart_item_params)
    if @cart_item.customer_id == current_customer.id

      if CartItem.exists?(item_id: @cart_item.item_id, customer_id: @cart_item.customer_id)
        existing_item = CartItem.find_by(item_id: @cart_item.item_id, customer_id: @cart_item.customer_id)
        existing_item.amount += @cart_item.amount.to_i
        existing_item.save
      else
        @cart_item.save
      end
    redirect_to cart_items_path
    else
      render :index
    end
end

def index
  @cart_items = CartItem.where(customer_id: current_customer.id)
  @items = Item.all
  @total = 0
  @amount_options = (1..10).to_a
end

def destroy_all
  @cart_items = CartItem.where(customer_id: current_customer.id)
  if @cart_items.present? && current_customer.id == @cart_items.first.customer_id
    @cart_items.destroy_all
    redirect_to cart_items_path
  else
    render :index
  end
end

def update
  @cart_item = CartItem.find(params[:id])
  if @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  else
    redirect_to cart_items_path
  end
end

def destroy
  @cart_item = CartItem.find(params[:id])
  @cart_item.destroy
  redirect_to cart_items_path
end

private

def cart_item_params
  params.require(:cart_item).permit(:item_id, :customer_id, :amount)
end


end
