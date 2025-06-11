class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :user,        null: false, foreign_key: true
      t.integer    :rating,      null: false
      t.text       :comment,     null: false

      t.timestamps
    end
  end
end
