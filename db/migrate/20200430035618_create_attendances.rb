class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.date :worked_on # 日付
      t.datetime :started_at # 出社時間
      t.datetime :finished_at # 退社時間
      t.datetime :before_started_at # 変更前出社時間
      t.datetime :before_finished_at # 変更前退社時間
      t.datetime :edit_started_at # 編集用出社時間
      t.datetime :edit_finished_at # 編集用退社時間
      t.string :note # 備考
      t.time :scheduled_end_time # 終了予定時間
      t.boolean :next_day, default: false # 翌日
      t.boolean :change, default: false # 変更
      t.string :business_process # 業務処理内容
      t.string :overwork_request_status # 残業申請の状態
      t.string :edit_request_status # 編集申請の状態
      t.string :confirmation # 残業申請の承認者
      t.string :edit_confirmation # 編集申請の承認者
      t.date :approval_date # 編集申請承認日
      
      
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
