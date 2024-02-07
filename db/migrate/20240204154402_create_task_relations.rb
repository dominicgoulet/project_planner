class CreateTaskRelations < ActiveRecord::Migration[7.1]
  def change
    create_table :task_relations do |t|
      t.references :task, null: false, foreign_key: true
      t.references :blocked_by, null: false, foreign_key: { to_table: :tasks }

      t.timestamps
    end
  end
end
