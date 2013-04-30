class RenameLargeCoverUrlToLargeImage < ActiveRecord::Migration
  def up
    rename_column :videos, :large_cover_url, :large_image
  end

  def down
  end
end
