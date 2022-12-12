class AddCityToEvent < ActiveRecord::Migration
  def change
    add_column :events, :city, :string, limit: 30
  end
end
