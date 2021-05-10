class PurchaseLog < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :destination
end
