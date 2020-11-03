User.create!(
  name: "賛急屋",
  email: "398@sankyuya.com",
  password: "sankyuya",
  password_confirmation: "sankyuya"
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

Category.create!(
  name: "弁当",
  color:"#FFFFFF",
  user_id: 0
)
