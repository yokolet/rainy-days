class AddConstraintToRevisedProvider < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:users, :provider, false)
  end
end
