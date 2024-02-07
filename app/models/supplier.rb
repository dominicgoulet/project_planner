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
class Supplier < ApplicationRecord
  has_many :expenses

  default_scope { order('unaccent(name) ASC') }

  def cost
    @cost ||= expenses.sum(&:amount)
  end
end
