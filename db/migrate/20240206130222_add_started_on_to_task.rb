class AddStartedOnToTask < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :started_on, :date
  end
end
