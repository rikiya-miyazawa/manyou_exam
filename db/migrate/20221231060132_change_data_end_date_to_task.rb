class ChangeDataEndDateToTask < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :end_date, :date
  end
end
