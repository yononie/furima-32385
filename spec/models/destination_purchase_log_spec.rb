require 'rails_helper'

RSpec.describe DestinationPurchaseLog, type: :model do
  before do
    @destination_purchase_log = FactoryBot.build(:destination_purchase_log)
  end

  it 'すべての値が正しく入力されていれば保存できること' do
    expect(@destination_purchase_log).to be_valid
  end
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
  it 'tokenが空では登録できないこと' do
    @destination_purchase_log.token = nil
    @destination_purchase_log.valid?
    expect(@destination_purchase_log.errors.full_messages).to include("Token can't be blank")
  end
end
