class Public::HomesController < ApplicationController
  def top
    @item_count = Item.count
    @items = Item.order(id: :desc).limit(4)
  end

  def about
  end
  
end
