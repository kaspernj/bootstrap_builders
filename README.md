# BootstrapBuilders

## Install

Add to your Gemfile and bundle:
```ruby
gem "bootstrap_builders"
```

Then add to your `ApplicationHelper` module:
```ruby
module ApplicationHelper
  include BootstrapBuilders::ApplicationHelper
end
```

Then add to your `application.js`:
```javascript
//= require bootstrap_builders
```

Then add to your `application.css`:
//= require bootstrap_builders

## Usage

### Panel

1. Panel in all its glory with elements and classes
2. Controls if `:right` argument is given
3. Table if `:table` argument is given

```haml
= bb_panel "Title of panel", right: button_content do
  Content of panel
```

### Panel with a table

```haml
= bb_panel "Title of panel", table: true do
  %tbody
    %tr
      %td= "Test"
```

You can add custom classes like this:
```haml
= bb_panel "Title of panel", table: {bs_classes: [:striped]} do
  %tbody
    %tr
      %td Test
```

### Table

1. Adds Bootstrap classes: "table", "table-hover", "table-striped"

```haml
= bb_table do
  %tbody
    %tr
      %td= "Test"
```

2. A table showing a models attributes:

```haml
= bb_table do
  %tbody
    = bb_attribute_rows @model, [:id, :created_at, :updated_at]
```

You can change the default classes like this:
```ruby
BootstrapBuilders.configuration.default_table_classes = [:striped, :hover]
```

The classes "bb-table" and "table" are always added.

### Buttons

1. Adds icons automatically
2. Adds labels automatically
3. Doesn't show button if CanCan doesn't allow it

```haml
= bb_new_btn url: [:admin, User]
= bb_edit_btn url: [:admin, user], mini: true
= bb_destroy_btn url: [:admin, user], label: false
= bb_btn "/url", "My label", :block, :lg, confirm: true
```

### Tabs

```haml
= bb_tabs do |tabs|
  = tabs.tab "Title" do
    Content of tab
```

```haml
= bb_tabs :pills, :stacked do |tabs|
  = tabs.tab "Title", "id-of-content-container" do
    Content of tab
  = tabs.tab "Load on demand", ajax_url: some_path
```

## Contributing to bootstrap_builders

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2016 kaspernj. See LICENSE.txt for
further details.
