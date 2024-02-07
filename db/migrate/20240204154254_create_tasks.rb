class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string :name
      t.decimal :budget
      t.decimal :cost
      t.integer :estimated_time
      t.integer :time_elapsed

      t.timestamps
    end
  end
end
