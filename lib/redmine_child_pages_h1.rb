module RedmineChildPagesH1

  HEADING_RE = /^\s*h1.\s+(.*)\s*$/i unless const_defined?(:HEADING_RE)

  def wiki_page_title(page, project)
    page_title(Wiki.find_page(page, :project => project))
  end

  def page_title(page)
    result = nil
    unless page.nil?
      if page.visible?
        unless page.content.nil?
          _text = page.content.text
          _m = _text.match(HEADING_RE)
          if _m.nil?
            result = page.pretty_title
          else
            result = _m[1].strip
          end
        end
      end
    end
    result
  end

  def remove_p(html)
    html.to_s.gsub(/<p>|<\/p>/, '').html_safe
  end

  module_function :wiki_page_title
  module_function :page_title
  module_function :remove_p
end