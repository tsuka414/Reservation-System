class BookRecordsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  def create
    @book_record = current_user.book_records.build(book_record_params)
    if @book_record.save
      update_daily_balance(@book_record)
      flash[:success] = "新しい収支が記録されました！"
      redirect_to(root_url)
    else
      flash.now[:danger] = "入力に不備があります。"
      render("static_pages/home")
    end
  end

  def destroy
    @book_record = BookRecord.find(params[:id])
    reduce_daily_balance(@book_record)
    @book_record.destroy
    flash[:success] = "収支データを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private

  def book_record_params
    params.require(:book_record).permit(:direction, :category, :amount, :record_date, :comment)
  end

  # book_record.record_dateとcurrent_user.idの複合キーを持つレコードがDailyBalanceモデル上に存在しない場合、
  # 新たにcurrent_userに紐づいたDailyBalanceモデルのレコードをrecord_dateで生成する。
  # 一方、該当するユーザーと日付のレコードがDailyBalanceモデル上に存在する場合は、既に存在するレコードの収支を今回登録する収支データの値で更新する。
  # HACK: 構造上、User.DailyBalance.BookRecordという形にできると思われるが、simple_calendarにおいてはDailyBalanceモデルをBookRecordモデルとは独立して
  #       持っていた方が書きやすい。
  def update_daily_balance(book_record)
    daily_balance = current_user.daily_balances.find_by(record_date: book_record.record_date)
    if daily_balance.nil?
      daily_balance = current_user.daily_balances.build(expenditure: 0, income: 0, record_date: book_record.record_date)
    end
    # 支出
    if book_record.direction.zero?
      daily_balance.expenditure += book_record.amount
    # 収入
    else
      daily_balance.income += book_record.amount
    end
    daily_balance.save
  end

  # 削除する場合、該当するユーザー・日付の複合キーを持つDailyBalanceレコードの収支を更新する。
  # NOTE: 収支が0になった時は、レコードを消さずに残しておく。カレンダー上では収支が0のレコードは表示されなくなる。
  def reduce_daily_balance(book_record)
    daily_balance = current_user.daily_balances.find_by(record_date: book_record.record_date)
    # 支出
    if book_record.direction.zero?
      daily_balance.expenditure -= book_record.amount
    # 収入
    else
      daily_balance.income -= book_record.amount
    end
    daily_balance.save
  end
end
