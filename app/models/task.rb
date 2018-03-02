class Task < ApplicationRecord
  module States
    PRIORITIES = %w(low normal high)
  end

  validates :text, presence: true
  validates_inclusion_of :priority, in: Task::States::PRIORITIES

  def complete?
    complete
  end
end
