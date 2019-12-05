class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :image, ImagesUploader
  # attachment :image, type: :image
  # has_one :item, dependent: :destroy  
  # attachment :image # 「:image」 はimage_idカラムのidを抜いたもの
  # accepts_nested_attributes_for :images
end
