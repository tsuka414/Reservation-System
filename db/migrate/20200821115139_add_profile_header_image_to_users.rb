class AddProfileHeaderImageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :header_image, :string
  end
end
