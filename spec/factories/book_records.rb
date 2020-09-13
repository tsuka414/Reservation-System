FactoryBot.define do
  factory :book_record do
    direction { 0 }
    category { 0 }
    amount { 1000 }
    record_date { Time.zone.local(2019, 1, 1) }
    comment { "a" * 140 }
  end
end
