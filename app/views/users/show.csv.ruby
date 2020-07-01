require 'csv'

CSV.generate do |csv|
  csv << ["勤怠情報"]
  
  csv << []
  column_names = %w(日付 出社時間 退社時間)
  csv << column_names
  @attendances.each do |attendance|
    column_values = [
      attendance.worked_on,
      if attendance.started_at.present?
        l(attendance.started_at, format: :time) 
      else
        ""
      end,
      if attendance.finished_at.present?
        l(attendance.finished_at, format: :time) 
      else
        ""
      end,
    ]
    csv << column_values  
  end
end