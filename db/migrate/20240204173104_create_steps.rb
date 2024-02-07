class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.string :name
      t.decimal :budget
      t.decimal :cost

      t.timestamps
    end
  end
end
