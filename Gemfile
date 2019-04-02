source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '4.2.10'

# Database
gem 'pg'

# Webserver
gem 'thin',    group: :development
gem 'unicorn', group: :production

# Asset Compilation
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# Configuration
gem 'figaro', git: 'https://github.com/laserlemon/figaro.git', branch: 'master'

# Authorization
gem 'pundit'

# Theme
source 'https://2gzsjvsxbBG9UWWXiJQx@gem.fury.io/lanresources/' do
  gem 'lr-simpliq' #, source: 'https://2gzsjvsxbBG9UWWXiJQx@gem.fury.io/lanresources/'
end

# JavaScript
gem 'jquery-rails'
gem 'turbolinks', git: 'https://github.com/rails/turbolinks.git'
gem 'dropzonejs-rails'
gem 'select2-rails'

# JSON
gem 'jbuilder', '~> 1.2'

# Models
gem 'strip_attributes'

# Views
gem 'haml-rails'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Markdown Processing
gem 'redcarpet'

# Files
gem 'fog-aws'
gem 'carrierwave'
gem 'mini_magick'
# gem 'rmagick'
# gem 'rghost'

# Mail
gem 'letter_opener', group: :development

# Tagging
gem 'acts-as-taggable-on'

# Ordering
gem 'acts_as_list'

# Encryption
gem 'bcrypt-ruby', '~> 3.1.2'

# Caching
gem 'memcachier'
gem 'dalli'

# Videos
gem 'yt'

# Heroku
gem 'rails_12factor', group: :production

# Monitoring
gem 'newrelic_rpm'

# Debugging
gem 'exception_notification'
group :development do
  gem 'web-console', '~> 2.1'
  gem "pry"
  gem 'meta_request'
  gem 'rails-erd'
  gem 'hirb'
  gem 'awesome_print'
  gem 'methodfinder'
  gem 'quiet_assets'
end

# Testing
group :development, :test do
  gem 'rspec-rails', '3.7.2'
  gem 'guard-rspec', '4.7.3'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner'
end

# Documentation
gem 'sdoc', group: :doc, require: false
