class RenameCalendarsToEvents < ActiveRecord::Migration
  def change
    rename_table :calendars, :events
  end
end
