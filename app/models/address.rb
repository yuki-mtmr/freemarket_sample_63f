class Address < ApplicationRecord

  belongs_to :user
  
  KANA_VALIDATION = /\A[\p{katakana}\p{blank}ー－]+\z/

  validates :first_name,              presence: true
  validates :last_name,               presence: true
  validates :first_name_kana,         presence: true, format: { with: KANA_VALIDATION, message: 'はカタカナで入力して下さい。'}
  validates :last_name_kana,          presence: true, format: { with: KANA_VALIDATION, message: 'はカタカナで入力して下さい。'}
  validates :postal_code,             presence: true, length: {maximum: 100}
  validates :region,                  presence: true
  validates :city,                    presence: true
  validates :street,                  presence: true
  validates :phone_number,            length: {maximum: 100}
end
