module ApplicationHelper
  def current_user
      User.find(session[:user_id]) if session[:user_id]
  end

  def tel_to(text)
    groups = text.to_s.scan(/(?:^\+)?\d+/)
    link_to text, "tel:#{groups.join '-'}"
  end

  def is_textable?(value)
    ' (textable)' if value
  end
end
