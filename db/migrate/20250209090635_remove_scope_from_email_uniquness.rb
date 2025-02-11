class RemoveScopeFromEmailUniquness < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, name: 'index_users_on_email_and_provider'
    add_index :users, 'lower(email)', name: 'index_users_on_lower_email', unique: true
  end
end
