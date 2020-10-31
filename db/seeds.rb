User.create!(
  name: "sample",
  email: "sample@sample.com",
  password: "samplesample",
  password_confirmation: "samplesample"
)

Category.create!(
  name: "宴会",
  color:"#FFFFFF",
  user_id: 0
)

Category.create!(
  name: "席のみ",
  color:"#FFFFFF",
  user_id: 0
)

Category.create!(
  name: "ランチ",
  color:"#FFFFFF",
  user_id: 0
)