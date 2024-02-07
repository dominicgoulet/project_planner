class AddBlockingParentToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :blocking_parent, null: true, foreign_key: { to_table: :tasks }
  end
end
