module Helpers
  def log_in(user)
    # ホーム画面へアクセス
    visit root_path
    # ログインボタンをクリック
    click_on "ログイン"
    # フォームに入力
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    # ログイン(ボタンの方だけを指定する)
    click_button "ログイン"
  end
end
