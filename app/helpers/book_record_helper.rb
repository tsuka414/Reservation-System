module BookRecordHelper
  # userが持つdate(月)の収支データを全て読み出し、pie_chartのパラメーター配列として返す
  def monthly_expenditure_by_category(user, date)
    book_records = BookRecord.where(user_id: user.id, record_date: date.in_time_zone.all_month)
    parameters = initialize_parameter_array(user.id)
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
