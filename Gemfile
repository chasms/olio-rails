source 'https://rubygems.org'

# Specify the Ruby version used for local development (see .ruby-version)
ruby '3.4.5'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '0.18.4'
# Use Puma as the app server
gem 'puma', '~> 3.0'
gem 'active_model_serializers', '0.10.0'
gem 'nokogiri', '~> 1.13.10'
gem 'poltergeist'
gem 'phantomjs', :require => 'phantomjs/poltergeist'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt'
gem 'jwt'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
gem 'rack-cors', :require => 'rack/cors'
gem 'rswag-api'
gem 'rswag-ui'
gem 'nio4r', '~> 2.5'
gem 'ffi', '>= 1.15.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '>= 3.8'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:windows, :jruby]
gem "bigdecimal", "~> 3.2"
gem "mutex_m", "~> 0.3.0"
gem "ostruct", "~> 0.6.3"

gem "benchmark", "~> 0.4.1"
