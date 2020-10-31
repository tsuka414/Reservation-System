class AddColorToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :color, :string
    rename_column :categories, :category_name, :name
  end
end