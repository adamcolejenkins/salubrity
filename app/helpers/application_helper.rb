module ApplicationHelper
  def active_if_current(path)
    'active' if current_page?(path)
  end

  def active_if(conditions)
    'active' if conditions
  end

  def identify(user)
    if user.name and user.surname or user.name
      "#{user.name} #{user.surname}"
    else
      user.email
    end
  end

  def tab_for(name, path)
    content_tag :dd, class: active_if_current(path) do
      link_to name, path, target: "_self"
    end
  end
end