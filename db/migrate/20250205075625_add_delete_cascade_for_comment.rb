class AddDeleteCascadeForComment < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :comments, :posts
    add_foreign_key :comments, :posts, on_delete: :cascade
    remove_foreign_key :comments, :users
    add_foreign_key :comments, :users, on_delete: :cascade
  end
end
