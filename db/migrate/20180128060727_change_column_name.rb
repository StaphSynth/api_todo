class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :name, :item
  end
end
