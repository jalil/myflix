class RemovePostionNumberFromLineItems < ActiveRecord::Migration
  def up
    remove_column :line_items, :postion
  end

  def down
    add_column :line_items, :postion, :integer
  end
end
