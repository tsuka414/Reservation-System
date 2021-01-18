FactoryBot.define do
  factory :change_history do
    category { "MyString" }
    comment { "MyText" }
    contact { "MyString" }
    number { 1 }
    started_at { "2021-01-17 12:02:32" }
    finished { "2021-01-17 12:02:32" }
    name { "MyString" }
    record_date { "2021-01-17" }
    writer { "MyString" }
    record_id { 1 }
  end
end
