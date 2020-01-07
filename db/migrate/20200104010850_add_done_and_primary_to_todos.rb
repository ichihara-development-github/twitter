class AddDoneAndPrimaryToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :done, :integer
    add_column :todos, :primary, :integer
  end
end
