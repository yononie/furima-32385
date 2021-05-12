require 'rails_helper'

RSpec.describe DestinationPurchaseLog, type: :model do
  before do
    @destination_purchase_log = FactoryBot.build(:destination_purchase_log)
    @destination_purchase_log.user_id = FactoryBot.build(:user)
    @destination_purchase_log.item_id = FactoryBot.build(:item)
  end

  context '内容に問題ない場合' do
  it 'すべての値が正しく入力されていれば保存できること' do
    expect(@destination_purchase_log).to be_valid
  end
  it 'building_nameが空でも保存できること' do
    @destination_purchase_log.building_name = ""
    expect(@destination_purchase_log).to be_valid
  end
  end

  context '内容に問題がある場合' do
  it '郵便番号が7桁以上の場合、保存できない' do
    @destination_purchase_log.postal_code = '12345678'
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include('Postal code is invalid')
  end
  it '郵便番号にハイフンが含まれない場合、保存できない' do
    @destination_purchase_log.postal_code = '1234567'
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include('Postal code is invalid')
  end
  it '郵便番号に文字がある場合、保存できない' do
    @destination_purchase_log.postal_code = 'aあ'
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include('Postal code is invalid')
  end
  it '電話番号が11桁以上の場合、保存できない' do
    @destination_purchase_log.phone_number = '090123456789'
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include('Phone number is invalid')
  end
  it '電話番号にハイフンがある場合、保存できない' do
    @destination_purchase_log.phone_number = '090-1234-5678'
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include('Phone number is invalid')
  end
  it '電話番号に文字がある場合、保存できない' do
    @destination_purchase_log.phone_number = 'aあ'
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include('Phone number is invalid')
  end
  it 'cityが空の場合、保存できない' do
    @destination_purchase_log.city = ''
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include("City can't be blank")
  end
  it 'addressが空の場合、保存できない' do
    @destination_purchase_log.address = ''
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include("Address can't be blank")
  end
  it 'region_idが0の場合、保存できない' do
    @destination_purchase_log.region_id = 0
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include('Region must be other than 0')
  end
  it 'user_idが空の場合、保存できない' do
    @destination_purchase_log.user_id = ""
    @destination_purchase_log.valid?
    binding.pry
    expect(@destination_purchase_log.errors.full_messages).to include("User can't be blank")
  end
  it 'item_idが空の場合、保存できない' do
    @destination_purchase_log.item_id = nil
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include("Item can't be blank")
  end
  it 'tokenが空では登録できないこと' do
    @destination_purchase_log.token = nil
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include("Token can't be blank")
  end
  end
end
