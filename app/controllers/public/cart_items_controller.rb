class Public::CartItemsController < ApplicationController

def create
  @cart_item = CartItem.new(cart_item_params)
  if @cart_item.save
    redirect_to cart_items_path
  else
    render :create
  end
end

def index
  @cart_items = CartItem.all
  @items = Item.all
end

def destroy
  @cart_item = CartItem.find(params[:id])
  @cart_item.destroy
  redirect_to cart_items_path
end

def destroy_all
  @cart_items = CartItem.where(customer_id: params[:customer_id])
  if @cart_items.present? && current_customer.id == @cart_items.first.customer_id
    @cart_items.destroy_all
    redirect_to cart_items_path
  else
    render :index
  end
end

private

def cart_item_params
  params.require(:cart_item).permit(:item_id, :customer_id, :amount)
end


end
