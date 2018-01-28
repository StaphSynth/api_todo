require 'faker'

FactoryBot.define do
  factory :task do
    item { Faker::Hacker.say_something_smart }
    priority { Task::States::PRIORITIES.sample }
    complete { false }
  end
end
