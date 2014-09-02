module ApplicationHelper
  def full_title(title)
    base_title = "Ruby on Rails Tutorial Sample App"
    title.empty? ? base_title : "#{base_title} | #{title}"
  end
end
