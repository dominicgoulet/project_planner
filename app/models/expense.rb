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
class Expense < ApplicationRecord
  belongs_to :step
  belongs_to :supplier
  belongs_to :payment_method

  broadcasts_to ->(expense) { [:expenses] }, inserts_by: :prepend, targets: 'expenses', partial: 'expenses/expense'
end
