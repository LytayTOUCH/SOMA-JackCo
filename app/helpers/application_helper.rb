module ApplicationHelper
  def google_map_api_drawing
    javascript_include_tag 'https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=drawing'
  end
  def google_chart_api
    javascript_include_tag 'https://www.google.com/jsapi'
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "SOMA Farms Management System"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
