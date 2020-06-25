module AttendancesHelper
  
  def attendance_state(attendance)
    if Date.current == attendance.worked_on
      return '出社' if attendance.started_at.nil?
      return '退社' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    return false
  end
  
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0 ))
  end
  
  def format_hour(time)
    format("%.2d", time.hour)
  end
  
  def format_min(time)
    format("%.2d", (((time.min) / 15) * 15))
  end
  
  # 時間外時間
  def overwork_hour(designated_work_end_time, scheduled_end_time, next_day)
    if next_day == true
     format("%.2f", (((((scheduled_end_time.hour - designated_work_end_time.hour ) * 60) + (scheduled_end_time.min - designated_work_end_time.min)) / 60.0 + 24)))
    else
     format("%.2f", (((((scheduled_end_time.hour - designated_work_end_time.hour ) * 60) + (scheduled_end_time.min - designated_work_end_time.min)) / 60.0)))
    end
  end
end
