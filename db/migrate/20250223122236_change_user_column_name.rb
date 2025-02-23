class ChangeUserColumnName < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :uid, :username
  end
end
