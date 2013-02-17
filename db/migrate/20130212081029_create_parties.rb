class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :index

      t.timestamps
    end
  end
end
