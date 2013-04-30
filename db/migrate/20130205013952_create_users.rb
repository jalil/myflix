class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :full_name
      t.string :password_digest
      t.string :email
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
