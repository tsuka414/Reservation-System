class AddDepartmentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :department, :string
    add_column :users, :employee_number, :integer
    add_column :users, :uid, :string
  end
end
