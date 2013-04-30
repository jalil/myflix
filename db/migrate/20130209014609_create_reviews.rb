class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :video_id
      t.text :content
      t.integer :rating
      t.timestamps
    end

    add_index :reviews, :user_id
    add_index :reviews, :video_id
  end

  def down
    drop_table :reviews
  end
end
