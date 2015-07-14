class EditingUserModel < ActiveRecord::Migration
  def change
    remove_column :users, :name, :email

    add_column :users, :username, :string
    change_column :users, :username, :string, null: false
    add_index :users, :username, unique: true
  end
end
