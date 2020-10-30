User.create!(
  name: "sample",
  email: "sample@sample.com",
  password: "samplesample",
  password_confirmation: "samplesample"
)

Category.create!(
  name: "宴会",
  user_id: 0
)

Category.create!(
  name: "席のみ",
  user_id: 0
)

Category.create!(
  name: "ランチ",
  user_id: 0
)