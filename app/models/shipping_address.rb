class ShippingAddress < ApplicationRecord

  belongs_to :customer

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  def set
    "〒" + postal_code + "　" + address + "　" + name
  end

end
