class Order < ApplicationRecord

  has_many :order_details
  belongs_to :customer


  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :payment_method, presence: true
  validates :customer_id, presence: true
  validates :total_payment, presence: true
  validates :postage, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }

  def with_tax_price
    (price * 1.1).floor
  end

end
