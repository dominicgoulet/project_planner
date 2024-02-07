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
class TaskRelation < ApplicationRecord
  belongs_to :task
  belongs_to :blocked_by, class_name: 'Task'
end
