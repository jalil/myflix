class Invitations < ActiveRecord::Migration
  def up
    create_table :invitations do |t|
      t.integer :sender_id
      t.string  :token
      t.string  :recipient_email

      t.timestamps
    end
  end

  def down
    drop_table :invitations
  end
end
