module RedmineChildPagesH1::H1
  Redmine::WikiFormatting::Macros.register do
    desc "Add link to wiki page with title from page h1 content. Examples:

{{h1(Some Page)}}
{{h1(project:Some Page)}}"
    macro :h1 do |obj, args|
      if args.empty?
        raise 'This macro can\' be called with no argument.'
      else
        _page = args.first.to_s
        _title = RedmineChildPagesH1.wiki_page_title(_page, obj.project)
        unless _title.nil?
          _title = '|' + _title
        end
        _textile = "[[#{_page}#{_title}]]"
        res = textilizable(_textile, :object => obj, :headings => false)
        RedmineChildPagesH1.remove_p(res).html_safe
      end
    end
  end
end