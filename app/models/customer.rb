class Customer < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :orders
  has_many :shipping_addresses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name, presence: true
  validates :last_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
end
