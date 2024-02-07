# == Schema Information
#
# Table name: task_materials
#
#  id           :bigint           not null, primary key
#  task_id      :bigint           not null
#  material_id  :bigint           not null
#  quantity     :integer
#  unit_price   :decimal(, )
#  taxes_amount :decimal(, )
#  total_amount :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class TaskMaterial < ApplicationRecord
  belongs_to :task
  belongs_to :material

  before_save :calculate_total_amount

  private

  def calculate_total_amount
    subtotal = quantity * unit_price
    self.taxes_amount = (subtotal * 0.14975).round(2)
    self.total_amount = (subtotal + taxes_amount).round(2)
  end
end
