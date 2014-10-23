module ApplicationHelper
  def active_if_current(path)
    'active' if current_page?(path)
  end

  def identify(user)
    if user.name and user.surname or user.name
      "#{user.name} #{user.surname}"
    else
      user.email
    end
  end
end