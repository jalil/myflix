class AddVideoIdToLine < ActiveRecord::Migration
  def self.up
    add_column :lines, :video_id, :integer
  end

  def self.down
    remove_column :lines, :video_id
  end
end
