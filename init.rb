plugin_name = :redmine_child_pages_h1

Rails.configuration.to_prepare do
  %w{global_toc}.each do |file_name|
    require_dependency "#{plugin_name}/#{file_name}"
  end
end

Redmine::Plugin.register plugin_name do
  name 'Redmine Child Pages H1 plugin'
  author 'Konstantin Borisov'
  description 'This is a plugin for Redmine with wiki macro that shows child pages tree like child_pages, but with page titles instead of page names'
  version '0.0.1'
  url 'https://github.com/hitsoft-redmine/redmine_child_pages_h1'
  author_url 'https://github.com/smeagol74'
end
