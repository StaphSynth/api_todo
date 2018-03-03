require 'faker'

FactoryBot.define do
  factory :task do
    text { Faker::Hacker.say_something_smart }
    priority { Task::PRIORITIES.sample }
    complete { false }
  end
end
