class AddReminderMethodType < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TYPE reminder_method AS ENUM ('TXT', 'EMAIL', 'PHONE');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE reminder_method;
    SQL
  end
end
