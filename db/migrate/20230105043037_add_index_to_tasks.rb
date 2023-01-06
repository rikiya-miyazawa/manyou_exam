class AddIndexToTasks < ActiveRecord::Migration[6.0]
  def change
    add_index :tasks, [:title, :start_status]
    add_index :users, :email, unique: true
  end
end
