class Item < ApplicationRecord
  has_one :purchase_log
  belongs_to :user
  has_one_attached :image
  has_many :messages, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :delivery_time
  belongs_to :region
  belongs_to :delivery_fee
  belongs_to :status
  belongs_to :category
  with_options numericality: { other_than: 0 } do
    validates :delivery_time_id
    validates :region_id
    validates :delivery_fee_id
    validates :status_id
    validates :category_id
  end
  with_options presence: true do
    validates :value, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :product, length: { maximum: 40 }
    validates :explanation, length: { maximum: 4000 }
    validates :image
  end
end
