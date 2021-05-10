FactoryBot.define do
  factory :purchase_log do
    region_id     { Faker::Number.within(range: 1..47) }
    city          { 'あ' }
    address       { 'あ' }
    postal_code   { '123-4567' }
    building_name { 'あ' }
    phone_number  { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end
