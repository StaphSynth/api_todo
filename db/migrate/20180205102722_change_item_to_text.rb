class ChangeItemToText < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :item, :text
  end
end
