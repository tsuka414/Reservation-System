require 'rails_helper'

RSpec.feature "ChangeUserSettings", type: :feature do
  background do
    # テストユーザーの作成
    @user = create(:user)
  end

  scenario "Change user name" do
    # ログイン処理
    log_in(@user)
    # 設定をクリック
    click_on "設定"
    # フォームに入力
    fill_in "user_name", with: "rails user"
    # 設定の変更
    click_button "設定の変更"
    # フラッシュメッセージを確認する
    expect(page).to have_content "基本情報を更新しました。"
    # ホーム画面へ移動し、名前が変わっていることを確認する
    visit root_path
    expect(page).to have_content "rails user さんの収支カレンダー"
  end

  scenario "Change email" do
    # ログイン処理
    log_in(@user)
    # 設定をクリック
    click_on "設定"
    # フォームに入力
    fill_in "user_email", with: "changed@sample.com"
    # 設定の変更
    click_button "設定の変更"
    # フラッシュメッセージを確認する
    expect(page).to have_content "基本情報を更新しました。"
    # 一度ログアウトする
    click_on "ログアウト"
    # ログインを試みる
    log_in(@user)
    # エラーメッセージが表示されることを確認する
    expect(page).to have_content "メールアドレスもしくはパスワードが違います。"
    # インスタンス変数のemailを変更後の文字列に置き換える
    @user.email = "changed@sample.com"
    # もう一度ログインし、今度は正常にログインできることを確認する
    log_in(@user)
    expect(current_path).to eq root_path
    expect(page).to have_content "#{@user.name} さんの収支カレンダー"
  end

  scenario "Change password" do
    # ログイン処理
    log_in(@user)
    # 設定をクリック
    click_on "設定"
    # フォームに入力
    fill_in "user_password", with: "aabbccdd"
    fill_in "user_password_confirmation", with: "aabbccdd"
    # 設定の変更
    click_button "設定の変更"
    # フラッシュメッセージを確認する
    expect(page).to have_content "基本情報を更新しました。"
    # 一度ログアウトする
    click_on "ログアウト"
    # ログインを試みる
    log_in(@user)
    # エラーメッセージが表示されることを確認する
    expect(page).to have_content "メールアドレスもしくはパスワードが違います。"
    # インスタンス変数のpasswordを変更後の文字列に置き換える
    @user.password = "aabbccdd"
    # もう一度ログインし、今度は正常にログインできることを確認する
    log_in(@user)
    expect(current_path).to eq root_path
    expect(page).to have_content "#{@user.name} さんの収支カレンダー"
  end
end
