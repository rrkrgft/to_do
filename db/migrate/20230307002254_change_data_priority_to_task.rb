class ChangeDataPriorityToTask < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :priority, 'integer USING CAST(priority AS integer)'
  end
  def down
    change_column :tasks, :priority, :string
  end
end
