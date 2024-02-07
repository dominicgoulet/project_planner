# == Schema Information
#
# Table name: tasks
#
#  id                 :bigint           not null, primary key
#  supplier_id        :bigint           not null
#  name               :string
#  budget             :decimal(, )
#  cost               :decimal(, )
#  estimated_time     :integer
#  time_elapsed       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  start_date         :date
#  completed_on       :date
#  planned_start_date :date
#  planned_end_date   :date
#  duration_in_days   :integer
#  started_on         :date
#
require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
