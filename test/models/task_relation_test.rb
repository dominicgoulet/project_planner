# == Schema Information
#
# Table name: task_relations
#
#  id            :bigint           not null, primary key
#  task_id       :bigint           not null
#  blocked_by_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class TaskRelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
