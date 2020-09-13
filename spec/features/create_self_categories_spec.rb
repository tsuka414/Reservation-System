require 'rails_helper'

RSpec.feature "CreateSelfCategories", type: :feature do
  background do
    # テストユーザーの作成
    @user = create(:user)
  end

  scenario "Create self category" do
    # ログイン処理
    log_in(@user)
    # 設定をクリック
    click_on "設定"
    # 収支カテゴリの追加をクリック
    click_on "収支カテゴリの追加"
    # フォームに入力
    fill_in "category_name", with: "test_category"
    # 設定の変更
    click_button "カテゴリの追加"
    # フラッシュメッセージを確認する
    expect(page).to have_content "新しい収支カテゴリを登録しました。"
    # ホーム画面へ移動し、カテゴリが選択肢に追加されていることを確認する
    visit root_path
    expect(page).to have_select("カテゴリ", options: %w[test_category])
  end
end
