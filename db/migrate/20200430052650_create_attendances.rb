class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.datetime :started_at
      t.datetime :finished_at
      t.string :note
      t.time :scheduled_end_time
      t.boolean :next_day, default: false
      t.boolean :change, default: false
      t.string :business_process
      t.string :confirmation # 残業申請の承認者
      t.string :overwork_request_status # 残業申請の状態
      t.string :edit_confirmation # 編集申請の承認者
      t.string :edit_request_status # 編集申請の状態

      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
