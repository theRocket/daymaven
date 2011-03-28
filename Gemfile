source 'http://rubygems.org'

gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem "haml"
gem 'devise', '1.2.rc'
gem "oa-oauth", '0.2.0.beta5', :require => "omniauth/oauth"
gem "fb_graph"
gem "twitter"
gem "geokit-rails3"
gem "will_paginate", "~> 3.0.pre2"
#gem "more", :git => "git://github.com/theRocket/more.git" # Rails 3 and Heroku compatible fork

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:

group :development do
  gem 'mysql2' #Heroku does pg
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem "nifty-generators"
  gem "ruby-debug19", :require => 'ruby-debug'
end

gem "mocha", :group => :test



