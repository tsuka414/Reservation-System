FactoryBot.define do
  factory :daily_balance do
    expenditure { 500 }
    income { 500 }
    record_date { Time.zone.local(2019, 1, 1) }
  end
end
