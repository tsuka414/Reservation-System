class CreateChangeHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :change_histories do |t|
      t.string :category
      t.text :comment
      t.string :contact
      t.integer :number
      t.time :started_at
      t.time :finished
      t.string :name
      t.date :record_date
      t.string :writer
      t.integer :record_id

      t.timestamps
    end
  end
end
