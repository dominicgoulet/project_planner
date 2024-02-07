class CreateTaskMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :task_materials do |t|
      t.references :task, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :taxes_amount
      t.decimal :total_amount

      t.timestamps
    end
  end
end
