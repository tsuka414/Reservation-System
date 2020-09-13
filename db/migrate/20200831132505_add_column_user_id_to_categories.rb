class AddColumnUserIdToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :user_id, :integer
  end
end
