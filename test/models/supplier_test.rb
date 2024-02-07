# == Schema Information
#
# Table name: suppliers
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  budget     :decimal(, )
#  color      :string
#
require "test_helper"

class SupplierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
