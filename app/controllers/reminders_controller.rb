# == Schema Information
#
# Table name: reminders
#
#  id              :integer          not null, primary key
#  date            :date
#  completed       :boolean          default(FALSE)
#  customer_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  reminder_method :enum
#  error           :text
#
# Indexes
#
#  index_reminders_on_completed        (completed)
#  index_reminders_on_customer_id      (customer_id)
#  index_reminders_on_reminder_method  (reminder_method)
#
# Foreign Keys
#
#  fk_rails_d934f5a924  (customer_id => customers.id)
#

class RemindersController < ApplicationController
  def index
    @page_name = 'Reminders'
    @reminders = Reminder.order date: :asc
  end

  def new
    @page_name = 'New Reminder'
    @customer_id = params[:customer_id]
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new reminder_params

    if @reminder.save
      customer_id = params[:reminder][:customer_id]
      redirect_to customer_path(customer_id, anchor: 'reminders'), notice: 'Reminder Added'
    else
      @page_name = 'New Reminder'
      @customer_id = params[:customer_id]
      @reminder = Reminder.new
      render :new
    end

  end

  def edit
    @reminder = Reminder.find params[:id]
    @page_name = "Editing Reminder for: #{@reminder.customer.title}"
  end

  def update
    @reminder = Reminder.find params[:id]
    @page_name = "Editing Reminder for: #{@reminder.customer.title}"
    if @reminder.update reminder_params
      redirect_to customer_path(@reminder.customer.id, anchor: 'reminders'), notice: 'Reminder Updated'
    else
      @reminder = Reminder.find params[:id]
      @page_name = "Editing Reminder for: #{@reminder.customer.title}"
      render :edit
    end

  end

  def destroy
    @reminder = Reminder.find params[:id]
    @reminder.destroy
    redirect_to customer_path(@reminder.customer.id, anchor: 'reminders'), notice: 'Reminder Deleted'
  end

  private

  def reminder_params
    params
      .require(:reminder)
      .permit(:customer_id, :date, :reminder_method, :completed)
  end
end
