class AddColorToSupplier < ActiveRecord::Migration[7.1]
  def change
    add_column :suppliers, :color, :string
  end
end
