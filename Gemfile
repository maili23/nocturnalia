source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
# Use Font Awesome in Rails
gem "font-awesome-rails"
# Use Font Awesome for sidebar and navbar links
gem 'awesome_link'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.3.3'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'database_cleaner'
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'pg'
end

# For authentication
gem 'devise'

# For authorization
gem 'cancancan', '~> 1.10'

## Gemfile for Rails 3+, Sinatra, or Merb
gem 'will_paginate', '~> 3.1.1'

  ## RSpec for testing
%w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
  gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
end

## For functional testing
gem 'rails-controller-testing'

#FactoryGirl for testing
gem 'factory_girl_rails', '~> 4.0'

#Stripe for Payments
gem 'stripe'

#MemCachier + Dalli to improve loading times
gem 'dalli'

#Redis for caching
gem 'redis-rails'

gem 'newrelic_rpm'



