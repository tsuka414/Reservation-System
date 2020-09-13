class AddIndexDailyBalancesRecordDate < ActiveRecord::Migration[5.1]
  def change
    add_index :daily_balances, %i[user_id record_date], unique: true
  end
end
