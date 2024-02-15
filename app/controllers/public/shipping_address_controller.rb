class Public::ShippingAddressController < ApplicationController

  before_action :authenticate_customer!

  def create
    @s_address = ShippingAddress.new(shipping_address_params)
    @s_address.customer_id = current_customer.id
    if @s_address.save
      redirect_to shipping_address_index_path
    else
      render :index
    end
  end

  def index
    @s_addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

  def show
    @s_address = ShippingAddress.find(params[:id])
  end

  def edit
    @s_address = ShippingAddress.find(params[:id])
  end

  def update
    @s_address = ShippingAddress.find(params[:id])
    if @s_address.update(edit_shipping_address_params)
      redirect_to shipping_address_index_path
    else
      render :edit
    end
  end

  def destroy
    @s_address = ShippingAddress.find(params[:id])
    @s_address.destroy
    redirect_to shipping_address_index_path
  end

  private

  def shipping_address_params
    params.permit(:name, :address, :postal_code)
  end

  def edit_shipping_address_params
    params.require(:shipping_address).permit(:name, :address, :postal_code)
  end

end
