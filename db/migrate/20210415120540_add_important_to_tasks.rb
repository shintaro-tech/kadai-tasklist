class AddImportantToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :important, :boolean, default: false, null: false
  end
end
