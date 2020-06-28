module UsersHelper
  
  def format_basic_info(time)
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
  
  def overwork_hour(designated_work_end_time, scheduled_end_time, next_day)
    if next_day == true
     format("%.2f", (((((scheduled_end_time.hour - designated_work_end_time.hour ) * 60) + (scheduled_end_time.min - designated_work_end_time.min)) / 60.0 + 24)))
    else
     format("%.2f", (((((scheduled_end_time.hour - designated_work_end_time.hour ) * 60) + (scheduled_end_time.min - designated_work_end_time.min)) / 60.0)))
    end
  end
end
