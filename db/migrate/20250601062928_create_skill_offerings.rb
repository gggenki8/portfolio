class CreateSkillOfferings < ActiveRecord::Migration[7.0]
  def change
    create_table :skill_offerings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :available_time
      t.text :details

      t.timestamps
    end
  end
end
