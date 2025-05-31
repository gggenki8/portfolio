class RenameProfileToIntroductionInUsers < ActiveRecord::Migration[7.0]
  def change
    def change
      rename_column :users, :profile, :introduction
    end
  end
end
