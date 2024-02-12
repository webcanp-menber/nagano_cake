class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true
  validates :product_price, presence: true

end
