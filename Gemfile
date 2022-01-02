source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'bootsnap', require: false
gem 'dotenv-rails'
gem 'google_drive'
gem 'pg'
gem 'pry-rails'
# https://github.com/rails/rails/issues/43998
gem 'rails', git: 'https://github.com/rails/rails', branch: '7-0-stable'
gem 'sprockets-rails'
gem 'twitter'

group :development do
  gem 'byebug'
  gem 'rubocop-rails'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
end
