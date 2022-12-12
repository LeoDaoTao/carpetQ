class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.date :date
      t.time :time_start
      t.time :time_end
      t.text :note
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
