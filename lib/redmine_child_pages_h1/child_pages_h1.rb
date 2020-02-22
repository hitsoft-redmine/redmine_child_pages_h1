module RedmineChildPagesH1::ChildPagesH1
  Redmine::WikiFormatting::Macros.register do
    desc "Displays a list of child pages but with page titles instead of page names. With no argument, it displays the child pages of the current wiki page. Examples:

{{child_pages_h1}} -- can be used from a wiki page only
{{child_pages_h1(depth=2)}} -- display 2 levels nesting only
{{child_pages_h1(Foo)}} -- lists all children of page `foo`
{{child_pages_h1(proj:Foo)}} -- lists all children of page `foo` in project `proj`
{{child_pages_h1(Foo, parent=1)}} -- lists all children of page foo with a link to page Foo"
    macro :child_pages_h1 do |obj, args|
      args, options = extract_macro_options(args, :parent, :depth)
      options[:depth] = options[:depth].to_i if options[:depth].present?

      page = nil
      if args.size > 0
        page = Wiki.find_page(args.first.to_s)
      elsif obj.is_a?(WikiContent) || obj.is_a?(WikiContent::Version)
        page = obj.page
      else
        raise 'With no argument, this macro can be called from wiki pages only.'
      end
      raise 'Page not found' if page.nil? || !User.current.allowed_to?(:view_wiki_pages, page.wiki.project)
      pages = page.self_and_descendants(options[:depth]).group_by(&:parent_id)
      _textilizable = -> (txt) { textilizable(txt, :object => obj, :headings => false) }
      _link_to = -> (name = nil, options = nil, html_options = nil, &block) { link_to(name, options, html_options, &block) }
      RedmineChildPagesH1::ChildPagesH1.render_page_hierarchy(pages, _textilizable, _link_to, options[:parent] ? page.parent_id : page.id)
    end
  end

  def render_page_hierarchy(pages, textilizable, link_to, node = nil, options = {})
    content = +''
    if pages[node]
      content << "<ul class=\"pages-hierarchy\">\n"
      pages[node].each do |page|
        content << "<li>"
        href = {:controller => 'wiki', :action => 'show', :project_id => page.project, :id => page.title, :version => nil}
        content << link_to.call(textilizable.call(RedmineChildPagesH1::page_title(page)), href,
                           :title => (options[:timestamp] && page.updated_on ? l(:label_updated_time, distance_of_time_in_words(Time.now, page.updated_on)) : nil))
        content << "\n" + RedmineChildPagesH1::ChildPagesH1.render_page_hierarchy(pages, textilizable, link_to, page.id, options) if pages[page.id]
        content << "</li>\n"
      end
      content << "</ul>\n"
    end
    content.html_safe
  end

  module_function :render_page_hierarchy
end