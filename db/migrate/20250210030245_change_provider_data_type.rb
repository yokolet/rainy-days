class ChangeProviderDataType < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :provider, :string
    add_column :users, :provider, :integer
  end
end
