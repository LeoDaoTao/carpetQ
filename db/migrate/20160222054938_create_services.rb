class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.money :price, currency: { present: false }

      t.timestamps null: false
    end
  end
end
