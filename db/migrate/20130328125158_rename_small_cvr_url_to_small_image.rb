class RenameSmallCvrUrlToSmallImage < ActiveRecord::Migration
  def change
    rename_column :videos, :small_cvr_url, :small_image
  end

  def down
  end
end
