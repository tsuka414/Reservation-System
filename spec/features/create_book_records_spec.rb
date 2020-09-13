require 'rails_helper'

RSpec.feature "CreateBookRecords", type: :feature do
  background do
    # テストユーザーの作成
    @user = create(:user)
    # カテゴリの作成
    @category = create(:category)
  end

  scenario "Create book record" do
    # ログイン処理
    log_in(@user)
    # フォームに入力
    choose "book_record_direction_0" # 支出
    select @category.name, from: "book_record_category" # カテゴリ
    fill_in "book_record_amount", with: "500" # 金額
    select "2019", from: "book_record_record_date_1i" # 年
    select "1月", from: "book_record_record_date_2i" # 月
    select "1", from: "book_record_record_date_3i" # 日
    fill_in "book_record_comment", with: "comment" # コメント
    # 収支の登録
    click_on "収支の登録"
    # フラッシュメッセージを確認する
    expect(page).to have_content "新しい収支が記録されました！"
    # 登録日の収支ページを開く
    visit user_daily_balance_url(@user, "2019-01-01")
    # 登録した内容が存在することを確認する
    expect(page).to have_selector ".expenditure-category", text: @category.name
    expect(page).to have_selector ".comment", text: "comment"
    expect(page).to have_selector ".expenditure-amount", text: "500"
  end
end
