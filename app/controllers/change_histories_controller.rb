class ChangeHistoriesController < ApplicationController
  def index
    @change_histories = ChangeHistory.all
  end

  def destroy
    changehistory = ChangeHistory.find(params[:id])
    changehistory.destroy
    #reduce_daily_balance(@book_record)
    flash[:success] = "履歴を削除しました。"
    redirect_back(fallback_location: root_path)
  end
end
