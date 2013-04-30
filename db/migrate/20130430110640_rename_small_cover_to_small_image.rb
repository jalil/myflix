class RenameSmallCoverToSmallImage < ActiveRecord::Migration
  def up
    rename_column :videos, :small_cover_url, :small_image
  end

  def down
  end
end
