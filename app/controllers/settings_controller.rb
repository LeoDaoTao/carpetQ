# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  var        :string           not null
#  value      :text
#  thing_id   :integer
#  thing_type :string(30)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_settings_on_thing_type_and_thing_id_and_var  (thing_type,thing_id,var) UNIQUE
#

class SettingsController < ApplicationController
  def index
    @page_name = 'Settings'
    @settings = Setting.unscoped.sort
  end

  def edit
    @page_name = 'Edit Setting'
    @setting = Setting.unscoped.find params[:id]
  end

  def update
    @setting = Setting.unscoped.find params[:id]
    @setting.update setting_params
    redirect_to settings_path
  end

  private

  def setting_params
    params
      .require(:setting)
      .permit(:value)
  end
end
