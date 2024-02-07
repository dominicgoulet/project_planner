class AddBudgetToSupplier < ActiveRecord::Migration[7.1]
  def change
    add_column :suppliers, :budget, :decimal
  end
end
