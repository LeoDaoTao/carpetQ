class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note_text

      t.timestamps null: false
    end
  end
end
