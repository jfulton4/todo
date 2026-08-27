class ChangeCompletedDefaultOnTasks < ActiveRecord::Migration
  def up
    change_column_default :tasks, :completed, false
    change_column_null    :tasks, :completed, false, false
  end

  def down
    change_column_null    :tasks, :completed, true
    change_column_default :tasks, :completed, nil
  end
end