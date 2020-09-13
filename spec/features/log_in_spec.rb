require 'rails_helper'

RSpec.feature "LogIn", type: :feature do
  background do
    # テストユーザーの作成
    @user = create(:user)
  end

  scenario "Enter the correct parameters to log_in" do
    # ホーム画面へアクセス
    visit root_path
    # ログインボタンをクリック
    click_on "ログイン"
    # フォームに入力
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: @user.password
    # ログイン(ボタンの方だけを指定する)
    click_button "ログイン"
    # ホームへリダイレクトされ、ログインしたユーザーの名前が表示されていることを確認する
    expect(current_path).to eq root_path
    expect(page).to have_content "#{@user.name} さんの収支カレンダー"
  end

  scenario "Enter the incorrect parameters to log_in" do
    # ホーム画面へアクセス
    visit root_path
    # ログインボタンをクリック
    click_on "ログイン"
    # フォームに入力(誤ったパスワードを入力)
    fill_in "session_email", with: @user.email
    fill_in "session_password", with: @user.password + "9"
    # ログイン(ボタンの方だけを指定する)
    click_button "ログイン"
    # エラーメッセージが表示されることを確認する
    expect(page).to have_content "メールアドレスもしくはパスワードが違います。"
  end
end
