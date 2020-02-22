# Redmine Child Pages H1

This is a plugin for Redmine with wiki macro that works like `child_pages` but instead of page names shows the `h1` element of the child page. 

## Example

```
{{child_pages_h1}} -- can be used from a wiki page only
{{child_pages_h1(depth=2)}} -- display 2 levels nesting only
{{child_pages_h1(Foo)}} -- lists all children of page `foo`
{{child_pages_h1(proj:Foo)}} -- lists all children of page `foo` in project `proj`
{{child_pages_h1(Foo, parent=1)}} -- lists all children of page foo with a link to page Foo"

{{h1(Foo)}} -- shows the link to the Foo page with it's h1 as link text
```

## Installation

1. Clone or copy files into the Redmine plugins directory
   ```
   git clone https://github.com/hitsoft-redmine/redmine_child_pages_h1.git plugins/redmine_child_pages_h1
   ```
2. Restart Redmine

## License

[LGPL-3.0](LICENSE)