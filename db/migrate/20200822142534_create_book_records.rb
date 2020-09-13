class CreateBookRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :book_records do |t|
      t.integer :type
      t.integer :category
      t.integer :amount
      t.date :record_date
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :book_records, %i[user_id record_date]
  end
end
