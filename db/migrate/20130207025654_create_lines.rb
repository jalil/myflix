class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :user

      t.timestamps
    end
    add_index :lines, :user_id
  end
end
