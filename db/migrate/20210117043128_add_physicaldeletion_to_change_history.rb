class AddPhysicaldeletionToChangeHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :change_histories, :physicaldeletion, :boolean, default: false, null: false
  end
end
