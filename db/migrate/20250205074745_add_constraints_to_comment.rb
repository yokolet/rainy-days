class AddConstraintsToComment < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:comments, :body, false)
    add_reference(:comments, :reply, foreign_key: { to_table: :comments, on_delete: :cascade }, index: false)
  end
end
