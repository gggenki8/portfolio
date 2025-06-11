class RemoveUserTypeFromUsers < ActiveRecord::Migration[7.0]
  def change
    if column_exists?(:users, :user_type)
      remove_column :users, :user_type, :string
    end
  end
end
