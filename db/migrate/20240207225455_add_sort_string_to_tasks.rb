class AddSortStringToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :sort_string, :string
  end
end
