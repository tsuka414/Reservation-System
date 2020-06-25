# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             superior: false)

User.create!(name: "Jyotyo1",
             email: "jyotyo1@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false,
             superior: true)
             
User.create!(name: "Jyotyo2",
             email: "jyotyo2@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false,
             superior: true)

User.create!(name: "General1",
             email: "general1@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false,
             superior: false)

User.create!(name: "General2",
             email: "general2@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false,
             superior: false)
             
Base.create!(base_number: "1",
             base_name: "東京",
             base_format: "出勤"
             )
             
Base.create!(base_number: "2",
             base_name: "京都",
             base_format: "出勤"
             )
             
Base.create!(base_number: "3",
             base_name: "三重",
             base_format: "退勤"
             )
             
             