# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false |
| first_name         | string  | null: false |
| last_name          | string  | null: false |
| kana_first         | string  | null: false |
| kana_last          | string  | null: false |
| birthday           | integer | null: false |

### Association

- has_many :items
- has_many :destinations
- has_many :purchase_logs

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| product         | string     | null: false                    |
| category_id     | integer    | null: false                    |
| status_id       | integer    | null: false                    |
| explanation_id  | integer    | null: false                    |
| value_id        | integer    | null: false                    |
| delivery_fee_id | integer    | null: false                    |
| region_id       | integer    | null: false                    |
| delivery_time   | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- has_one :purchase_log
- has_one :destination
- belongs_to :user

## purchase_logs テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :destination

## destinations テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| region_id     | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     | null: false                    |
| postal_code   | integer    | null: false                    |
| purchase_log  | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_log