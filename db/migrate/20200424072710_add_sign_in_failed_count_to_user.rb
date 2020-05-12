class AddSignInFailedCountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sign_in_failed_count, :integer, default: 0, after: :password_digest
  end
end
