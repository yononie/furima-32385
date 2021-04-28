FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '000aaa' }
    password_confirmation { password }
    first_name            { 'あ亜ア' }
    last_name             { 'あ亜ア' }
    kana_first            { 'ア' }
    kana_last             { 'ア' }
    birthday              { Faker::Date.between(from: '1930-1-1', to: '2016-12-31') }
  end
end
