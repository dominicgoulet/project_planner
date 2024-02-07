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
require "test_helper"

class TaskMaterialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
