class BookRecordsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :set_book_record, only: %i[edit update destroy]

  def index
    @day = params[:date].nil? ?
    Date.current : params[:date].to_date
    @book_records = BookRecord.where(record_date: @day).order(:record_date)
  end

  def create
    @book_record = BookRecord.new(book_record_params)
    if @book_record.save
      #update_daily_balance(@book_record)
      flash[:success] = "予約が完了しました。"
      redirect_to(root_url)
    else
      flash.now[:danger] = "必須項目を入力してください。"
      render("static_pages/home")
    end
  end

  def edit
  end

  def update
    @book_record = BookRecord.find(params[:id])
    set_history(@book_record.name, @book_record.category, @book_record.number, @book_record.record_date,@book_record.comment, 
                @book_record.started_at, @book_record.writer, @book_record.contact, @book_record.id)
    if @book_record.update_attributes(book_record_params)
      flash[:success] = '予約情報を更新しました。'
      redirect_to(book_records_path(params: {date: @book_record.record_date}))
    else
      flash.now[:danger] = "入力に不備があります。"
    end
  end

  def destroy
    #reduce_daily_balance(@book_record)
    set_history(@book_record.name, @book_record.category, @book_record.number, @book_record.record_date,@book_record.comment, 
                @book_record.started_at, @book_record.writer, @book_record.contact, @book_record.id)
    @book_record.destroy
    @chengehistory.update_attributes(physicaldeletion: true)
    flash[:success] = "予約を削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private

  def book_record_params
    params[:book_record].permit(:name, :category, :number, :record_date, :comment, :started_at, :finished_at, :writer, :contact)
  end

  # before_action

  def set_book_record
    @book_record = BookRecord.find(params[:id])
  end

  def set_history(name, category, number, record_date, comment, started_at, writer, contact, record_id)
    @chengehistory = ChangeHistory.new(name: name, category: category, number: number, record_date: record_date,
                                      comment: comment, started_at: started_at, writer: writer, contact: contact, record_id: record_id)
    @chengehistory.save
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
