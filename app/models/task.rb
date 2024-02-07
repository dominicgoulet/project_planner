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
  belongs_to :root_task, class_name: 'Task', optional: true
  belongs_to :blocking_parent, class_name: 'Task', optional: true

  has_many :task_relations, dependent: :destroy
  has_many :task_materials, dependent: :destroy

  accepts_nested_attributes_for :task_relations, allow_destroy: true, reject_if: lambda { |attributes| attributes['blocked_by_id'].blank? }
  accepts_nested_attributes_for :task_materials, allow_destroy: true, reject_if: lambda { |attributes| attributes['material_id'].blank? || attributes['quantity'].blank? || attributes['unit_price'].blank? }

  default_scope { order('sort_string, planned_start_date, unaccent(name) ASC') }

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
    ped = psd

    if psd.saturday?
      psd += 2.days
    elsif psd.sunday?
      psd += 1.day
    end

    (did - 1).times do
      ped += 1.day

      if ped.saturday?
        ped += 3.days
      elsif psd.sunday?
        ped += 2.days
      end
    end

    rt = nil
    d = 0

    parent = task_relations.first&.blocked_by
    while parent && parent.task_relations.any?
      parent = parent.task_relations.first&.blocked_by
      d += 1
    end
    rt = parent

    bp = blocking_parent_calculation

    parent_ids = [name]
    parent = bp
    while parent
      parent_ids << parent.name
      parent = parent.blocking_parent
    end
    ss = parent_ids.reverse.join(' -> ')

    update(
      duration_in_days: did,
      planned_start_date: psd,
      planned_end_date: ped,
      root_task: rt, # not used
      depth: d, # not used
      blocking_parent: bp,
      sort_string: ss
    )
  end

  def duration_in_days_calculation
    ((estimated_time || 0) / 8).round(0)
  end

  def planned_start_date_caulculation
    return started_on if started_on.present?

    max_date = start_date || Date.today

    TaskRelation.includes(:blocked_by, :task).where(task_id: id).each do |parent|
      parent_end_date = parent.blocked_by.planned_end_date
      if parent_end_date > max_date
        max_date = parent_end_date
      end
    end

    max_date
  end

  def blocking_parent_calculation
    bp = nil

    max_date = start_date || Date.today

    TaskRelation.includes(:blocked_by, :task).where(task_id: id).each do |parent|
      parent_end_date = parent.blocked_by.planned_end_date
      if parent_end_date > max_date
        max_date = parent_end_date
        bp = parent.blocked_by
      end
    end

    bp
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
