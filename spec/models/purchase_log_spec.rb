require 'rails_helper'

RSpec.describe PurchaseLog, type: :model do
  before do
    @purchase_log = FactoryBot.build(:purchase_log)
  end

  it '必要な情報を入力をすれば、購入情報が保存される' do
    expect(@purchase_log).to be_valid
  end
  it '郵便番号が7桁以上の場合、保存できない' do
    @purchase_log.postal_code = '12345678'
    @purchase_log.valid?
    expect(@purchase_log.errors.full_messages).to include('Postal code is invalid')
  end
  it '郵便番号にハイフンが含まれない場合、保存できない' do
    @purchase_log.postal_code = '1234567'
    @purchase_log.valid?
    expect(@purchase_log.errors.full_messages).to include('Postal code is invalid')
  end
  it '郵便番号に文字がある場合、保存できない' do
    @purchase_log.postal_code = '1あa7'
    @purchase_log.valid?
    expect(@purchase_log.errors.full_messages).to include('Postal code is invalid')
  end
  it '電話番号が11桁以上の場合、保存できない' do
    @purchase_log.phone_number = '090123456789'
    @purchase_log.valid?
    expect(@purchase_log.errors.full_messages).to include('Phone number is invalid')
  end
  it '電話番号にハイフンがある場合、保存できない' do
    @purchase_log.phone_number = '090-1234-5678'
    @purchase_log.valid?
    expect(@purchase_log.errors.full_messages).to include('Phone number is invalid')
  end
  it '電話番号に文字がある場合、保存できない' do
    @purchase_log.phone_number = '0あa8'
    @purchase_log.valid?
    expect(@purchase_log.errors.full_messages).to include('Phone number is invalid')
  end
  it 'tokenが空では登録できないこと' do
    @purchase_log.token = nil
    @purchase_log.valid?
    expect(@purchase_log.errors.full_messages).to include("Token can't be blank")
  end
end
