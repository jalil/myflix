class RenameLrgCvrUrlToLrgImage < ActiveRecord::Migration
  def change
    rename_column :videos, :lrg_cvr_url, :large_image
  end

  def down
  end
end
