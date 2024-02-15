class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true
  validates :product_price, presence: true

  enum status: { unable: 0, wait_production: 1, now_production: 2, finish_production: 3 }

end
