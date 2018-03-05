class TaskSerializer < ActiveModel::Serializer
  attributes :text, :priority, :complete
end
