class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name
      t.decimal :top_margin
      t.decimal :bottom_margin
      t.decimal :left_margin
      t.decimal :right_margin
      t.integer :columns
      t.integer :rows
      t.decimal :column_gutter
      t.decimal :row_gutter

      t.timestamps null: false
    end
  end
end
