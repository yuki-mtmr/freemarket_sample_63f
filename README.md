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
|phone_number|integer|null: false|
|image|string|null: false|
|evaluation|integer|null: false|


### Association
- has_many :items
- has_many :follows
- has_many :likes
- has_many :address

## addressesテーブル
|Column|Type|Option|
|------|----|------|
|postal_code|string|null: false|
|region|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building|string|
|user_id|references|null: false, foreign_key: true|


### Association
- belongs_to :user

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
- has_many :comments

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



