# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  note_text  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer
#

class NotesController < ApplicationController
  def index
    @notes = Note.all.order(created_at: :desc)
    @page_name = "Notes"
  end

  def new
    @note = Note.new
    @page_name = "New Note"
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      redirect_to notes_path, notice: "Note Added"
    else
      render :new
    end
  end

  def edit
    @page_name = "Edit Note"
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to notes_path, notice: "Note Successfully Updated"
    else
      render :new
    end
  end

  private

  def note_params
    params
      .require(:note)
      .permit(:note_text, :status)
  end
end
