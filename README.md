# bootstrap_builders

## Install

Add to your Gemfile and bundle:
```ruby
gem "bootstrap_builders"
```

Then add to your `ApplicationHelper` module:
```ruby
module ApplicationHelper
  include BootstrapBuilders::Helpers
end
```

## Usage

### Box
```haml
= box "Title of box", right: button_content do
  Content of box
```

### Box with a table
```haml
= box "Title of box", table: true do
  %tbody
    %tr
      %td= "Test"
```

### Table
```haml
= bs_table do
  %tbody
    %tr
      %td= "Test"
```

### Buttons
```haml
= bs_new_button url: [:admin, User]
= bs_edit_button url: [:admin, user], mini: true
= bs_destroy_button url: [:admin, user], label: false
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

