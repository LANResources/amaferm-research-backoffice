source 'https://rubygems.org'
source 'https://2gzsjvsxbBG9UWWXiJQx@gem.fury.io/lanresources/'

ruby '2.1.0'

gem 'rails', '4.1.0'

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
gem 'lr-simpliq'

# JavaScript
gem 'jquery-rails'
gem 'turbolinks'
gem 'dropzonejs-rails'
gem 'select2-rails'
gem 'best_in_place', git: 'https://github.com/bernat/best_in_place.git', branch: 'rails-4'

# JSON
gem 'jbuilder', '~> 1.2'

# Views
gem 'haml-rails'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Markdown Processing
gem 'redcarpet'

# Files
gem 'carrierwave'
gem 'carrierwave-dropbox', '~> 1.1.0'
gem 'mini_magick'

# Mail
gem 'letter_opener', group: :development

# Tagging
gem 'acts-as-taggable-on'

# Encryption
gem 'bcrypt-ruby', '~> 3.1.2'

# Caching
gem 'memcachier'
gem 'dalli'

# Heroku
gem 'rails_12factor', group: :production

# Monitoring
gem 'newrelic_rpm'

# Debugging
gem 'exception_notification'
group :development do
  gem "pry"
  gem 'meta_request'
  gem 'rails-erd'
  gem 'hirb'
  gem 'awesome_print'
  gem 'methodfinder'
end

# Testing
group :development, :test do
  gem 'rspec-rails', '2.14.0'
  gem 'guard-rspec', '4.0.1'
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.1'
  gem 'childprocess', '0.3.9'
  gem 'terminal-notifier-guard'
  gem 'debugger'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner'
end

# Documentation
gem 'sdoc', group: :doc, require: false
