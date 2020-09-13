module DailyBalancesHelper
  # 支出と収入が共に0であれば真
  def empty_daily_balance?(daily_balance)
    return true if daily_balance.expenditure.zero? && daily_balance.income.zero?
  end

  # 日付とユーザーIDが合致するBookRecordレコードを全て取得する
  def extract_book_records(user_id, date)
    BookRecord.where(user_id: user_id, record_date: date)
  end

  # User(user_id)が持つ日付dateの収支データを全て読み出し、pie_chartのパラメーター配列として返す
  def daily_expenditure_by_category(user_id, date)
    book_records = BookRecord.where(user_id: user_id, record_date: date)
    parameters = initialize_parameter_array(user_id)
    book_records.each do |record|
      # 収入のレコードは参照しない
      next unless record.direction.zero?

      category = Category.find_by(id: record.category)
      category_name = category.nil? ? "未分類" : category.name
      parameters.each do |parameter|
        # 対象のレコードと同じカテゴリをパラメーター配列から探し、支出額を加算
        if parameter[0] == category_name
          parameter[1] += record.amount
          break
        end
      end
    end

    parameters = delete_if_amount_is_zero(parameters)
    parameters, colors = separate_color_column(parameters)

    [parameters, colors: colors, messages: { empty: "データがありません。" }]
  end
end
