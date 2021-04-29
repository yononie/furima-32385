require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it 'nicknameとemail、passwordとpassword_confirmation、ユーザー本名とユーザー本名のフリガナが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上、半角英数混合で、一致していれば登録できる' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'ユーザー本名、ユーザー本名のフリガナは、名字と名前が存在すれば登録できる' do
        @user.first_name = 'あ'
        @user.last_name = 'あ'
        @user.kana_first = 'ア'
        @user.kana_last = 'ア'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.first_name = 'あ'
        @user.last_name = 'あ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、全角（カタカナ）であれば登録できる' do
        @user.kana_first = 'ア'
        @user.kana_last = 'ア'
        @user.valid?
        expect(@user).to be_valid
      end
      it '生年月日があれば登録できる' do
        @user.birthday = '1930-1-1'
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailに＠を含まなければ登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '0a'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end
      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = '0000aa'
        @user.password_confirmation = '00aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'passwordに半角英数が混合で入力されていなければ登録できない(数字のみ)' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
      it 'passwordに半角英数が混合で入力されていなければ登録できない(半角英字のみ)' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
      it 'passwordに半角英数が混合で入力されていなければ登録できない(全角)' do
        @user.password = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password Include both letters and numbers'
      end
      it 'ユーザー本名の名字が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'ユーザー本名の名前が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'ユーザー本名フリガナの名字が空では登録できない' do
        @user.kana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana first can't be blank"
      end
      it 'ユーザー本名フリガナの名前が空では登録できない' do
        @user.kana_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Kana last can't be blank"
      end
      it 'ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.first_name = '?'
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid. Input full-width characters.'
      end
      it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.last_name = '?'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name is invalid. Input full-width characters.'
      end
      it 'ユーザー本名フリガナの名字は、全角（カタカナ）以外では登録できない' do
        @user.kana_first = 'あ亜?'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Kana first is invalid. Input full-width katakana characters.'
      end
      it 'ユーザー本名フリガナの名前は、全角（カタカナ）以外では登録できない' do
        @user.kana_last = 'あ亜?'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Kana last is invalid. Input full-width katakana characters.'
      end
      it '誕生日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
