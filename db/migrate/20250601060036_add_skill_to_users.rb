class AddSkillToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :skill, :string
  end
end
