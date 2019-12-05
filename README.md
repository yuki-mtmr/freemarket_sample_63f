# README

# freemarket_sample_63f DB設計
## usersテーブル
|Column|Type|Option|
|------|----|------|
|nickname|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|email|string|null: false|
|password|string|null: false|
|password_confirmation|string|null: false|
|birth_year|string|null: false|
|birth_month|string|null: false|
|birth_day|string|null: false|
|phone_number|string|null: false|
|image|string|null: false|
|evaluation|integer|null: false|


### Association
- has_many :items, dependent: :destroy
- has_many :follows, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :address, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :cards, dependent: :destroy

## addressesテーブル
|Column|Type|Option|
|------|----|------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|postal_code|string|null: false|
|region|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building|string|
|phone_number|string|
|user_id|references|null: false, foreign_key: true|


### Association
- belongs_to :user, dependent: :destroy

## cardsテーブル
|Column|Type|Option|
|------|----|------|
|user_id|integer|null: false|
|customer_id|string|null: false|
|card_id|string|null: false|

### Association
- belonsg_to_user, dependent: :destroy

## itemsテーブル
|Column|Type|Option|
|------|----|------|
|price|integer|null: false|
|name|string|null: false|
|image|string|null: false|
|condition|string|null: false|
|description|text|null: false|
|item_size|string|null: false|
|region|string|null: false|
|postage|string|null: false|
|shipping_date|string|null: false|
|saller_id|references|null: false , foreign_key: true|
|buyer_id|references|null: false , foreign_key: true|

### Association
- belongs_to :user
- has_many :comments, dependent: :destroy

## Salersテーブル
|user|references|null: false , foreign_key: true|
|item|references|null: false , foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

## categoriesテーブル
|Column|Type|Option|
|------|----|------|
|name|string|null: false|
|ancestry	|string|

### Association
- has_ancestry

## statusテーブル
|Column|Type|Option|
|------|----|------|
|selling_item|integer|null: false|
|sold_item|integer|null: false|
|suspended_item|integer|null: false|
|item_id|foreign_key: true|null: false|

### Association
- belongs_to :user
- belongs_to :item

## likesテーブル
|Column|Type|Option|
|------|----|------|
|user_id|foreign_key: true|null: false|
|item_id|foreign_key: true|null: false|

### Association
- belongs_to :user
- belongs_to :item

## commentsテーブル
|Column|Type|Option|
|------|----|------|
|comment|text|null: false|
|item_id|foreign_key: true|null: false|
|user_id|foreign_key: true|null: false|

### Association
- belongs_to :item
- belongs_to :user nnn


