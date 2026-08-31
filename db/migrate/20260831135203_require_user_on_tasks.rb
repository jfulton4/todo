class RequireUserOnTasks < ActiveRecord::Migration
  def up
    Task.where(user_id: nil).delete_all
    change_column_null :tasks, :user_id, false
  end

  def down
    change_column_null :tasks, :user_id, true
  end
end
