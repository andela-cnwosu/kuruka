module HtmlHelper
  def tooltip_element(title)
    "<span class='opaque' data-toggle='tooltip' data-placement='top'"\
    " title='#{flight_departed_message}'>#{title}</span>".html_safe
  end

  def convert_to_html_class(text)
    text.tr(" ", "-").downcase
  end
end