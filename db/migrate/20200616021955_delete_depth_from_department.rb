class DeleteDepthFromDepartment < ActiveRecord::Migration[6.0]
  def up
    remove_column :departments, :depth
  end

  def down
    add_column :departments, :depth, :integer
  end
end
