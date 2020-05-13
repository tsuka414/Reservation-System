# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

User.create!(name: "Jyotyo1",
             email: "jyotyo1@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)
             
User.create!(name: "Jyotyo2",
             email: "jyotyo2@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)

User.create!(name: "General1",
             email: "general1@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)

User.create!(name: "General2",
             email: "general2@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)