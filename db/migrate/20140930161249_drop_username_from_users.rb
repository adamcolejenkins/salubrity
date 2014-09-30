class DropUsernameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :username
    # remove_index :users, :username
  end
end
