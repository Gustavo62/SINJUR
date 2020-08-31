source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'tty-spinner'  
gem "simple_calendar", "~> 2.0" 
source 'https://rails-assets.org' do
  gem 'rails-assets-fullcalendar'
  gem 'rails-assets-momentjs'
end
gem 'ice_cube' 
gem 'zip-zip'
gem 'chartkick', '~> 2.2.0' 
gem 'groupdate'
gem 'bootstrap-sass' 
gem 'maskedinput-rails'
gem 'coffee-script-source' 
gem 'jquery_mask_rails', '~> 0.1.0'
gem 'momentjs-rails'
gem 'trix'
gem 'popper_js', '~> 1.14.5'
gem 'alertifyjs-rails'
gem 'kaminari', '~> 1.0'
gem 'rails-erd' 
gem 'twitter-bootstrap-rails-confirm'
gem 'bootbox-rails', '~>0.4' 
gem 'rails-assets-sweetalert2', '~> 5.1.1', source: 'https://rails-assets.org'
gem 'sweet-alert2-rails'
gem 'administrate'
gem 'cocoon'  
gem 'jquery-rails'
gem 'actiontext', github: 'kobaltz/actiontext', branch: 'archive', require: 'action_text' 
gem "image_processing", "~> 1.2"
gem 'activestorage'
gem 'bootstrap-datetimepicker-rails'
gem 'jquery-ui-rails', '5.0.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rails-i18n', '~> 5.1'
gem 'devise'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :production do
  gem 'mysql2'#, '~/0.3.18'
end


group :development do
  gem 'capistrano-rails', '~> 1.4', require:false
  gem 'capistrano-bundler', '~> 1.5'
  gem 'capistrano', '~> 3.11', require:false
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'  
  gem 'better_errors', '~> 2.1', '>= 2.1.1'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'calendar_helper', path: 'calendar_helper'