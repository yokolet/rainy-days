class AddContraintsToPost < ActiveRecord::Migration[8.0]
  def change
    change_column_null(:posts, :title, false)
    change_column_null(:posts, :content, false)
    change_column(:posts, :content, :text, limit: 1000)
    remove_foreign_key(:posts, :users)
    add_foreign_key(:posts, :users, on_delete: :cascade)
  end
end
