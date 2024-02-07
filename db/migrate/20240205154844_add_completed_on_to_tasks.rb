class AddCompletedOnToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :completed_on, :date
  end
end
