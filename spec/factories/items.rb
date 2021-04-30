FactoryBot.define do
  factory :item do
    product          { Faker::Lorem.paragraph_by_chars(number: 40, supplemental: false) }
    category_id      { Faker::Number.within(range: 1..4) }
    status_id        { Faker::Number.within(range: 1..4) }
    delivery_fee_id  { Faker::Number.within(range: 1..2) }
    region_id        { Faker::Number.within(range: 1..47) }
    delivery_time_id { Faker::Number.within(range: 1..3) }
    value            { Faker::Number.within(range: 300..9_999_999) }
    explanation      { Faker::Lorem.paragraph_by_chars(number: 4000, supplemental: false) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    association :user
  end
end
