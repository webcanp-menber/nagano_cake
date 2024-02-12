class Public::ItemsController < ApplicationController

  def index
    @item_count = Item.count
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
  end

end