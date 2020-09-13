class RenameTypeColumnToBookRecords < ActiveRecord::Migration[5.1]
  def change
    rename_column :book_records, :type, :direction
  end
end
