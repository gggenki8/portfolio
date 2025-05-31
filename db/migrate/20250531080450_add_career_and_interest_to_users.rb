class AddCareerAndInterestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :career, :text
    add_column :users, :interest, :text
  end
end
