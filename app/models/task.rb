class Task < ApplicationRecord
  PRIORITIES = %w(low normal high).freeze

  validates :text, presence: true
  validates_inclusion_of :priority, in: PRIORITIES

  def complete?
    complete
  end
end
