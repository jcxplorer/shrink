module ApplicationHelper
  
  def navigation_for(*pages)
    output = "".html_safe
    pages.each do |page|
      active = controller.controller_name == page.to_s
      output << link_to(page.to_s.capitalize, page.to_sym, :class => active ? "active" : nil)
    end
    output
  end

end
