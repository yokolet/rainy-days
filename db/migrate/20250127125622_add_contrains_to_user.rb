class AddContrainsToUser < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:users, :provider, false)
    change_column_null(:users, :uid, false)
    change_column_null(:users, :email, false)
    add_index :users, [ :email, :provider ], unique: true
  end
end
