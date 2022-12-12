class AddDescriptionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :description, :string, limit: 100
  end
end
