class DailyBalancesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @daily_balance = DailyBalance.find_by(user_id: params[:user_id], record_date: params[:record_date])
  end
end
