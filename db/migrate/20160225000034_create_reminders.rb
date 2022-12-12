class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.date :date
      t.boolean :completed, default: false
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
