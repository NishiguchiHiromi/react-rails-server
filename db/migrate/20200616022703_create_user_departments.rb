class CreateUserDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_departments do |t|
      t.references :department, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
