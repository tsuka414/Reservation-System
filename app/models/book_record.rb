class BookRecord < ApplicationRecord
  #validates(:user_id, presence: true)
  #validates(:direction, presence: true, numericality: { less_than_or_equal_to: 1 })
  validates(:category, presence: true)
  #validates(:amount, presence: true, numericality: { greater_than: 0 })
  validates(:record_date, presence: true)
  validates(:comment, length: { maximum: 140 })
  validates(:name, presence: true, length: { maximum: 50 })
  validates(:number, presence: true)
  validates(:started_at, presence: true)
  validates(:writer, presence: true, length: { maximum: 50 })
  VALID_NUMBER_REGEX =  /\A\d{10}$|^\d{11}$|^\d{6}\z/
  validates(:contact, presence: true,
            format: { with: VALID_NUMBER_REGEX })

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
