class AddGenderAndBloodTypeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gender, :integer, null:false, after: :mail
    add_column :users, :blood_type, :integer, null:false, after: :gender
  end
end
