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

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| product       | string     | null: false                    |
| category      | text       | null: false                    |
| status        | string     | null: false                    |
| explanation   | text       | null: false                    |
| value         | integer    | null: false                    |
| delivery_fee  | integer    | null: false                    |
| region        | string     | null: false                    |
| delivery_time | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |

### Association

- has_one :purchase_log
- has_one :destination
- belongs_to :user

## purchase_logs テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| purchased_item | string     | null: false                    |
| buyer          | string     | null: false                    |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user

## destinations テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| prefecture     | string     | null: false                    |
| city           | string     | null: false                    |
| address        | string     | null: false                    |
| postal_code    | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |
| item           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item