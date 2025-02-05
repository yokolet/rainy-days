class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, limit: 50
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
