class CreateDailyBalances < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_balances do |t|
      t.integer :expenditure
      t.integer :income
      t.date :record_date
      t.references :user, foreign_key: true
    end
  end
end
