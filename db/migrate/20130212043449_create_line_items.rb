class CreateLineItems < ActiveRecord::Migration
  def up
    create_table :line_items do |t|
      t.integer :video_id
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    
  end
end
