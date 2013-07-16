class ChangeCoverUrlToCoverOnBooks < ActiveRecord::Migration
  def up
    rename_column :books, :cover_url, :cover
  end

  def down
    rename_column :books, :cover, :cover_url
  end
end
