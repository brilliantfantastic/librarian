class CreateBookShelves < ActiveRecord::Migration
  def change
    create_table :book_shelves do |t|
      t.string :name
      t.timestamps
    end
  end
end
