class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string :name
      t.string :url
      t.decimal :cost

      t.timestamps
    end
  end
end
