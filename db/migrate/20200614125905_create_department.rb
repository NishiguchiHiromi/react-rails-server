class CreateDepartment < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
