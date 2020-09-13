module StaticPagesHelper
  # 今月分の情報だけ抽出して、その合計を返す。
  def extract_balances_of_current_month(user, direction)
    current_month_records = DailyBalance.where(user_id: user.id, record_date: Time.zone.now.in_time_zone.all_month)
    sum = 0
    current_month_records.each do |record|
      sum += if direction.zero?
               record.expenditure
             else
               record.income
             end
    end

    sum
  end
end
