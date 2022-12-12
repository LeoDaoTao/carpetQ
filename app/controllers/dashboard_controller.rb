class DashboardController < ApplicationController
  def index
    @page_name = "Dashboard"
    @events = Event.today.order :time_start
    @phone_reminders = Reminder.phone.not_completed.until_today
  end
end
