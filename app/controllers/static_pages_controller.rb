class StaticPagesController < ApplicationController

  def home
    @first_day = params[:date].nil? ?
    Date.current : params[:date].to_date
    @last_day = @first_day.since(7.days)
    @book_records = BookRecord.where(record_date: @first_day..@last_day).order(:record_date)
  end

  def help
  end

  def about
  end
end
