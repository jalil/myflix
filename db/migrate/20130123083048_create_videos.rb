class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.binary :small_cvr_url
      t.binary :lrg_cvr_url
      t.text :description
      t.references :category

      t.timestamps
    end
    add_index :videos, :category_id
  end
end
