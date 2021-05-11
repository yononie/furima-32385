class DestinationPurchaseLog
  include ActiveModel::Model
  attr_accessor :region_id, :city, :address, :building_name, :postal_code, :phone_number, :token, :user_id, :item_id

  with_options presence: true do
    validates :region_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :phone_number, format: { with: /\A\d{11}\z/ }
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    purchase_log = PurchaseLog.create(user_id: user_id, item_id: item_id)
    Destination.create(region_id: region_id, city: city, address: address, building_name: building_name,
                       postal_code: postal_code, phone_number: phone_number, purchase_log_id: purchase_log.id)
  end
end
