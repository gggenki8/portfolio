class AddTitleToSkillOfferings < ActiveRecord::Migration[7.0]
  def change
    add_column :skill_offerings, :title, :string
  end
end
