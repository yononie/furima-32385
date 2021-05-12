class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchase_logs

  ln = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/
  zhira = /\A[ぁ-んァ-ン一-龥々]/
  zkata = /\A[ァ-ヶー－]+\z/

  with_options presence: true do
    validates :nickname, :birthday
    validates :password, :password_confirmation, length: { minimum: 6 },
                                                 format: { with: ln,
                                                           message: 'Include both letters and numbers' }
    with_options format: { with: zhira, message: 'is invalid. Input full-width characters.' } do
      validates :first_name, :last_name
    end
    with_options format: { with: zkata, message: 'is invalid. Input full-width katakana characters.' } do
      validates :kana_first, :kana_last
    end
  end
end
