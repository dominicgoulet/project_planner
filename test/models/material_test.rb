# == Schema Information
#
# Table name: materials
#
#  id          :bigint           not null, primary key
#  supplier_id :bigint           not null
#  name        :string
#  url         :string
#  cost        :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class MaterialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
