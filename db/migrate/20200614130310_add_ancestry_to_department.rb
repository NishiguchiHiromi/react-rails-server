class AddAncestryToDepartment < ActiveRecord::Migration[6.0]
  def change
    add_column :departments, :ancestry, :string, after: :name
    add_column :departments, :depth, :integer, after: :ancestry
    add_index :departments, :ancestry
  end
end
