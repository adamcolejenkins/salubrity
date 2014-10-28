module TitleHelper
  def page_title
    title = t page_title_translation_key, 
              page_title_context.merge(:default => :"titles.application")
    description = t page_description_translation_key, 
                    page_title_context.merge(:default => "")
    breadcrumbs = render_breadcrumbs separator: ' / '

    html = <<-HTML
    <div class="title">
    HTML

    unless breadcrumbs.blank?
      html += <<-HTML
        <div class="crumb">#{breadcrumbs}</div>
      HTML
    end

    unless title.blank?
      html += <<-HTML
        <h2>#{title}</h2>
      HTML
    end

    unless description.blank?
      html += <<-HTML
        <h3 class="subheader">#{description}</h3>
      HTML
    end

    html += <<-HTML
    </div>
    HTML

    html.html_safe
  end

  def page_title_translation_key
    :"titles.#{controller_name}.#{action_name}.title"
  end

  def page_description_translation_key
    :"titles.#{controller_name}.#{action_name}.describe"
  end

  def page_title_context
    controller.view_assigns.symbolize_keys
  end
end
