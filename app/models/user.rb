class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :items
  has_many :purchase_logs
  has_many :sns_credentials

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )

    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

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