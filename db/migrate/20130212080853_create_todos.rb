class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :Party

      t.timestamps
    end
  end
end
