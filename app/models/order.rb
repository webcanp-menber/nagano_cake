class Order < ApplicationRecord

  has_many :order_details
  belongs_to :customer

  def formatted_address
    "〒#{postal_code} #{address} #{name}"
  end

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :payment_method, presence: true
  validates :customer_id, presence: true
  validates :total_payment, presence: true
  validates :postage, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait_payment: 0, confirm_payment: 1, in_production: 2, preparing: 3, sent: 4 }

  def with_tax_price
    (price * 1.1).floor
  end

end
