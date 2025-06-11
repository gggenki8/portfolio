class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :user,           null: false, foreign_key: true
      t.references :skill_offering, null: false, foreign_key: true
      t.date :reserved_date,        null: false
      t.time :reserved_time,        null: false
      t.text :message,              null: false
      t.string :status,             null: false, default: "pending"

      t.timestamps
    end
  end
end
