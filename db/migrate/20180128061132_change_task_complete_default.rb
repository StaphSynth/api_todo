class ChangeTaskCompleteDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :tasks, :complete, false
  end
end
