class DailyBalance < ApplicationRecord
  belongs_to :user
  validates(:user_id, presence: true)
  validates(:expenditure, presence: true, numericality: { greater_than_or_equal_to: 0 })
  validates(:income, presence: true, numericality: { greater_than_or_equal_to: 0 })
  validates(:record_date, presence: true)

  def expenditure_income_hashed
    { "収入" => income, "支出" => expenditure }
  end

  # 実際にはメンバ変数ではないが、メンバ変数のように振舞うメソッド
  # ex. daily_balance.user_name => "sample_user"
  def user_name
    User.find_by(id: user_id).name
  end
end
