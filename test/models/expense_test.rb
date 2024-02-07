# == Schema Information
#
# Table name: expenses
#
#  id                :bigint           not null, primary key
#  date              :date
#  step_id           :bigint           not null
#  supplier_id       :bigint           not null
#  description       :string
#  payment_method_id :bigint           not null
#  amount            :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
