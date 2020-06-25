class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.datetime :started_at
      t.datetime :finished_at
      t.string :note
      t.references :user, foreign_key: true
      t.time :scheduled_end_time
      t.boolean :next_day, default: false
      t.string :business_process
      t.string :confirmation
      t.string :overwork_request_status

      t.timestamps
    end
  end
end
