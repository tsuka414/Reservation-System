class AddNameToBookRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :book_records, :name, :string
    add_column :book_records, :contact, :string
    add_column :book_records, :started_at, :time
    add_column :book_records, :finished_at, :time
    add_column :book_records, :number, :integer
    add_column :book_records, :writer, :string
  end
end
