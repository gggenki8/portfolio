class RenameIntroductionToProfileInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :profile, :introduction
  end
end
