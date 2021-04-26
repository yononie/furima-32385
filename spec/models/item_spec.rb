require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do

    context '商品を出品できる場合' do
      it '入力情報が正しい時、出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない場合' do
      it '商品画像が空の時、出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it '商品名が空の時、出品できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Product can't be blank"
      end
      it '商品名が40文字以上の時、出品できない' do
        @item.product = Faker::Lorem.paragraph_by_chars(number: 41, supplemental: false)
        @item.valid?
        expect(@item.errors.full_messages).to include "Product is too long (maximum is 40 characters)"
      end
      it '商品の説明が空の時、出品できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Explanation can't be blank"
      end
      it '商品の説明が4000文字以上の時、出品できない' do
        @item.explanation = Faker::Lorem.paragraph_by_chars(number: 4001, supplemental: false)
        @item.valid?
        expect(@item.errors.full_messages).to include "Explanation is too long (maximum is 4000 characters)"
      end
      it 'カテゴリーが空(id=0)の時、出品できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Category must be other than 0"
      end
      it '商品の状態が空(id=0)の時、出品できない' do
        @item.status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Status must be other than 0"
      end
      it '配送料の負担が空(id=0)の時、出品できない' do
        @item.delivery_fee_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery fee must be other than 0"
      end
      it '発送元の地域が空(id=0)の時、出品できない' do
        @item.region_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Region must be other than 0"
      end
      it '発送までの日数が空(id=0)の時、出品できない' do
        @item.delivery_time_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery time must be other than 0"
      end
      it '価格が空の時、出品できない' do
        @item.value = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Value can't be blank", "Value is not a number"
      end
      it '価格が300円以下の時、出品できない' do
        @item.value = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include "Value must be greater than or equal to 300"
      end
      it '価格が9999999円以上の時、出品できない' do
        @item.value = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "Value must be less than or equal to 9999999"
      end
      it '価格が半角数字以外では登録できない(全角数字の場合)' do
        @item.value = '１'
        @item.valid?
        expect(@item.errors.full_messages).to include "Value is not a number"
      end
      it '価格が半角数字以外では登録できない(全角文字の場合)' do
        @item.value = 'あ'
        @item.valid?
        expect(@item.errors.full_messages).to include "Value is not a number"
      end
      it '価格が半角数字以外では登録できない(半角英字の場合)' do
        @item.value = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include "Value is not a number"
      end
    end
  end
end