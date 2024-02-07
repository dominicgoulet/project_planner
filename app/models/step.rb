# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  name       :string
#  budget     :decimal(, )
#  cost       :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Step < ApplicationRecord
  has_many :expenses

  default_scope { order('unaccent(name) ASC') }

  def cost
    @cost ||= expenses.sum(&:amount)
  end
end
