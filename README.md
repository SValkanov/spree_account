Spree Account
============

## Installation

1. Add this extension to your Gemfile with this line:
  ```ruby
  gem 'spree_account', git: 'https://github.com/SValkanov/spree_account', branch: '3-1-stable'
  ```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_account:install
  ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.


Copyright (c) 2017 Stanislav Valkanov, released under the New BSD License
