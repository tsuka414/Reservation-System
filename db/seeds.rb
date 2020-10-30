User.create!(
  name: "sample",
  email: "sample@sample.com",
  password: "samplesample",
  password_confirmation: "samplesample"
)

User.create!(
  name: "mintia96",
  email: "wazap1121@gmail.com",
  password: "12345678",
  password_confirmation: "12345678"
)

User.create!(
  name: "testuser",
  email: "test1@gmail.com",
  password: "12345678",
  password_confirmation: "12345678"
)

Category.create!(
  name: "コース１",
  user_id: 0
)

Category.create!(
  name: "コース２",
  user_id: 0
)

Category.create!(
  name: "コース３",
  user_id: 0
)