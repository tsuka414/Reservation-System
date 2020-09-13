require 'rails_helper'

RSpec.feature "SignUp", type: :feature do
  scenario "Enter the correct parameters to sign up" do
    # ホーム画面へアクセス
    visit root_path
    # 会員登録ボタンをクリック
    click_on "会員登録"
    # フォームに入力
    fill_in "user_name", with: "sample user"
    fill_in "user_email", with: "sample@sample.com"
    fill_in "user_password", with: "12345678"
    fill_in "user_password_confirmation", with: "12345678"
    # 登録
    click_on "会員登録"
    # 会員登録に成功したことを確認する
    expect(page).to have_content "ようこそ！ sample userさん！"
  end

  scenario "Enter the incorrect parameters to sign up" do
    # ホーム画面へアクセス
    visit root_path
    # 会員登録ボタンをクリック
    click_on "会員登録"
    # フォームに入力(確認用パスワードを間違えてみる)
    fill_in "user_name", with: "sample user"
    fill_in "user_email", with: "sample@sample.com"
    fill_in "user_password", with: "12345678"
    fill_in "user_password_confirmation", with: "12345679"
    # 登録
    click_on "会員登録"
    # 会員登録に失敗し、エラーが表示されることを確認する
    expect(page).to have_content "フォームの入力内容にエラーがあります。"
  end
end
