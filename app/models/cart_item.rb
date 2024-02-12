class CartItem < ApplicationRecord
require './app/models/item'
has_one_attached :image
belongs_to :item
belongs_to :customer

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end

  def subtotal
    item.with_tax_price * amount
  end
  
  validates :customer_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true

end
