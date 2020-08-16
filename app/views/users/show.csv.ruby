require 'csv'

CSV.generate do |csv|
  csv << ["勤怠情報"]


  column_names = %w(日付 出社時間 退社時間)
  csv << column_names
  @attendances.each do |attendance|
    column_values = [
      attendance.worked_on,
      if attendance.started_at.present?
        format_hour(attendance.started_at) + ":" + format_min(attendance.started_at)
      else
        ""
      end,
      if attendance.finished_at.present?
        format_hour(attendance.finished_at) + ":" + format_min(attendance.finished_at)
      else
        ""
      end,
    ]
    csv << column_values
  end
end