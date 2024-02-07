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
class Material < ApplicationRecord
  belongs_to :supplier

  default_scope { order('unaccent(name) ASC') }
end
