class AddCalculationsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :planned_start_date, :date
    add_column :tasks, :planned_end_date, :date
    add_column :tasks, :duration_in_days, :integer
  end
end
