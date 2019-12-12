class Item < ApplicationRecord
  has_many :images, dependent: :destroy   # 「dependent: :destroy」でuserを削除すると関連するimageも削除される
  accepts_nested_attributes_for :images
  has_many :salers, dependent: :destroy
  belongs_to :user
  # belongs_to :address

  validates :name,                  presence: true
  validates :description,           presence: true
  validates :condition,             presence: true
  validates :region,                presence: true
  validates :postage,               presence: true
  validates :shipping_date,         presence: true
  # validates :price,                 presence: true, numericality: { only_integer: true, greater_than: 300, less_than: 9999999}

#   BigDecimal("1.23456").floor
end

