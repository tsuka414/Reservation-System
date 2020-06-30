require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(日付 退社時間)
  csv << csv_column_names
  @attendances.each do |day|
    csv_column_values = [
      l(day.worked_on, format: :short),
      if day.edit_finished_at.present? && day.attendance_status == 
    ]
    csv << csv_column_values
  end
end