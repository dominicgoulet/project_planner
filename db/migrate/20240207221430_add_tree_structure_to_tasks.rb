class AddTreeStructureToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :root_task, null: true, foreign_key: { to_table: :tasks }
    add_column :tasks, :depth, :integer
  end
end
