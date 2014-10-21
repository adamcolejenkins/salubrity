module KioskHelper
  
  def include_start_time(form)
    form.hidden_field(:started_at, class: 'kiosk-started-at')
  end
  
  def include_end_time(form)
    form.hidden_field(:ended_at, class: 'kiosk-ended-at')
  end

  def tag_replace(text, object)
    text.gsub(/\[([a-z\.\_]+)\]/) {
      
    }
  end
end
