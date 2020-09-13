class AddColumnToBookRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :book_records, :comment, :text
  end
end
