# README
#　20191103 フォークリポジトリテストのコメントアウト

# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|e-mail|string|null: false,unique:true|
|password|string|null: false,unique:true|
|passwordconfirmation|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthyear|integer|null: false|
|birthmonth|integer|null: false|
|birthday|integer|null: false|

### Association
- has_many :comments
- has_many :items
- has_many :likes
- has_many :traders
- has_many :notifications
- has_many :to_do_lists
- has_many :messages
- has_one :sns_credentials
- has_one  :address
- has_one :credit_card
- has_one :profile 


<!-- - has_many :reviews -->

## Profilesテーブル
|Column|Type|Options|
|------|----|-------|
|mobile_number|integer|null: false,unique:true|
|sales|integer||
|point|integer||
|image|string||
|text|text||
|user_id|references|null :false,FK :true|

### Association
belongs_to :user

## Addressテーブル
|Column|Type|Options|
|------|----|-------|
|postcode|integer|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|street|text||
|building_name|text||
|phone_number|integer||
|user_id|references|null :false,FK :true|

### Association
belongs_to :user

## cardsテーブル 
|Column|Type|Options|
|------|----|-------|
|customer_id|integer|null :false|
|card_id|integer|null :false|
|user_id|references|null :false,FK :true|

### Association
- belongs_to :user


## SNS_credenitalsテーブル
|Column|Type|Options|
|------|----|-------|
|uid|string|null: false,unique: true|
|provider|string|null: false|
|token|text||
|user_id|references|null: false,FK: true|

### Association
- belongs_to :user


## Reviewsテーブル
|Column|Type|Options|
|------|----|-------|
|review|integer|null: false|
|text|text|null: false|
|trader_id|references|null :false,FK :true|

### Association
- belongs_to :trader
- belongs_to :user


## Notificationsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null:flase,FK:true|

### Association
- belongs_to  :user


## TO_do_listsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null:flase,FK:true|

### Association
- belongs_to :user


## Likesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false,FK: true|
|user_id|references|null: false,FK: true|

### Association
- belongs_to :item
- belongs_to :user


## Brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false,unique: true|

### Association
- has_many :items


## Itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false,index :true|
|price|integer|null: false|
|text|text|null: false|
|condtion|integer|null: false|
|display|boolean|null: false|
|size_id|references|null: false,FK: true|
|brand_id|references|null: false,index: true,FK: true|
|category_id|references|null: false,index: true,FK: true|
|user_id|references|null: false,index: true,FK: true|

### Association
- belongs_to :brand
- belongs_to :category
- belongs_to :user
- belongs_to :size
- has_many :comments
- has_many :images
- has_many :likes
- has_one :trading


## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|genre|string|null: false,unique: true|
|ancestry|string||

### Association
- has_many :items
- has_ancestry


## Sizesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false,unique: true|

### Association
- has_many :categories,through: :size_charts
- has_many :items
- has_many :size_charts


## Size_chartsテーブル
|Column|Type|Options|
|------|----|-------|
|category_id|references|null: false,FK: true|
|size_id|references|null: false,FK: true|

### Association
- belongs_to :category
- belongs_to :size


## Imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item_id|refernces|null: false,FK: true|

### Association
- belongs_to :item


## Tradingsテーブル
|Column|Type|Options|
|------|----|-------|
|condition|integer|null:false|
|delivery_to|integer|null:false|
|payment|integer|null:false|
|status|integer|null: false|
|item_id|references|null: false,index: true,FK: true|
|trader_id|references|null: false,index: true,FK: true|
|shipping_id|reference|null: false,index: true,FK: true|

### Association
- belongs_to :item
- belongs_to :shipping 
- belongs_to :trader


## Tradersテーブル
|Column|Type|Options|
|------|----|-------|
|buyer_id|refernces|null: false,index: true,FK:{to_table: :users}|
|seller_id|refernces|null: false,index: true,FK:{to_table: :users}|

### Association
- belongs_to :buyer_id, class_name: "User"
- belongs_to :seller_id, class_name: "User"
- has_many :tradings
- has_many :reviews


## Shippingsテーブル
|Column|Type|Options|
|------|----|-------|
|charge|string|null:false|
|delivery_method|string|null:false|
|delivery_to|reference|null:false|
|days_to_be_delivered|integer|null:false|
|item_id|references|null:false,FK:true|

### Association
- belongs_to :item
- has_one :trading

## Commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null :false|
|item_id|references|null: false,index: true,FK:true|
|user_id|references|null: false,index: true,FK:true|

### Association
- belongs_to :item
- belongs_to :user


## Messagesテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null :false|
|user_id|reference|null :false|
|trading_id|reference|null :false|

### Association

- belongs_to :trading
- belongs_to :user


## Newssテーブル
|Column|Type|Options|
|------|----|-------|
|title|text|null:false|
|text|text|null:false|






This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
