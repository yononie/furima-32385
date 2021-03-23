# テーブル設計

## users テーブル

| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false |
| password | string | null: false |

### Association

- has_many :items
- has_many :purchase_logs

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| product     | string     | null: false                    |
| category    | text       | null: false                    |
| explanation | text       | null: false                    |
| value       | integer    | null: false                    |
| seller      | string     | null: false                    |
| user_id     | references | null: false, foreign_key: true |

### Association

- has_one :purchase_log
- has_many :users, through: purchase_logs

## purchase_logs テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| destination | string     | null: false                    |
| buyer       | string     | null: false                    |
| user_id     | references | null: false, foreign_key: true |
| items_id    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user