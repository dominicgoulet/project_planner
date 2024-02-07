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
class Task < ApplicationRecord
  belongs_to :supplier

  has_many :task_relations, dependent: :destroy
  has_many :task_materials, dependent: :destroy

  accepts_nested_attributes_for :task_relations, allow_destroy: true, reject_if: lambda { |attributes| attributes['blocked_by_id'].blank? }
  accepts_nested_attributes_for :task_materials, allow_destroy: true, reject_if: lambda { |attributes| attributes['material_id'].blank? || attributes['quantity'].blank? || attributes['unit_price'].blank? }

  default_scope { order('planned_start_date, unaccent(name) ASC') }

  scope :coming_up, ->(start_date, end_date) {
      where('(planned_start_date >= ? AND planned_start_date <= ?) OR (planned_start_date <= ? AND planned_end_date >= ?)', start_date, end_date, start_date, start_date)
  }

  broadcasts_to ->(task) { [:tasks] }, inserts_by: :append, targets: 'tasks', partial: 'tasks/task'

  def update_calculations!
    compute_calculated_fields

    children.each do |child|
      child.update_calculations!
    end
  end

  def compute_calculated_fields
    did = duration_in_days_calculation
    psd = planned_start_date_caulculation
    ped = [psd + did, Date.today].max

    update(
      duration_in_days: did,
      planned_start_date: psd,
      planned_end_date: ped
    )
  end

  def duration_in_days_calculation
    ((estimated_time || 0) / 8).round(0)
  end

  def planned_start_date_caulculation
    return started_on if started_on.present?

    max_date = start_date || Date.today

    TaskRelation.includes(:blocked_by, :task).where(task_id: id).each do |parent|
      parent_end_date = parent.blocked_by.planned_start_date_caulculation + parent.blocked_by.duration_in_days_calculation
      if parent_end_date > max_date
        max_date = parent_end_date
      end
    end

    max_date
  end

  def children
    Task.joins(:task_relations).where(task_relations: { blocked_by_id: id })
  end

  def started?
    started_on.present?
  end

  def completed?
    completed_on.present?
  end
end
