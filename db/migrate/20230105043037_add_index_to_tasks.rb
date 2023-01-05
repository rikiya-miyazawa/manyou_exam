class AddIndexToTasks < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, [:title, :start_status]
  end
end
