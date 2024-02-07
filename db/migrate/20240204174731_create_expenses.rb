class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.date :date
      t.references :step, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.string :description
      t.references :payment_method, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
