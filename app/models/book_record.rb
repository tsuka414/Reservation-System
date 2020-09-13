class BookRecord < ApplicationRecord
  belongs_to :user
  validates(:user_id, presence: true)
  validates(:direction, presence: true, numericality: { less_than_or_equal_to: 1 })
  validates(:category, presence: true)
  validates(:amount, presence: true, numericality: { greater_than: 0 })
  validates(:record_date, presence: true)
  validates(:comment, length: { maximum: 140 })

  # 実際にはメンバ変数ではないが、メンバ変数のように振舞うメソッド
  # ex. book_record.category_name => 趣味
  def category_name
    category = Category.find_by(id: self.category)
    category.nil? ? "未分類" : category.name
  end

  def category_color
    category = Category.find_by(id: self.category)
    category.nil? ? "#BBBBBB" : category.color
  end
end
