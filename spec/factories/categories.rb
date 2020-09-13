FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "test_category_#{n}" }
    sequence(:color) { |n| "#FFFFF#{n}" }
    user_id { 0 }
  end
end
