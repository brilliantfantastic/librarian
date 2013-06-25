class AddCryptedPasswordToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string
  end
end
