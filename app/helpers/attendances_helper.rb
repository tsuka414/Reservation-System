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
    format("%.2d",(((time.min) / 15) * 15))
  end
end
