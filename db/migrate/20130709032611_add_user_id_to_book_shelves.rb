class AddUserIdToBookShelves < ActiveRecord::Migration
  def change
    add_column :book_shelves, :user_id, :integer
  end
end
