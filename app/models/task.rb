class Task < ApplicationRecord
  module States
    PRIORITIES = %w(low medium high)
  end

  validates :item, presence: true
  validates_inclusion_of :priority, in: Task::States::PRIORITIES

  def complete?
    complete
  end
end
