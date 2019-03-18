# By placing all of Spree's shared dependencies in this file and then loading
# it for each component's Gemfile, we can be sure that we're only testing just
# the one component of Spree.
source 'https://rubygems.org'

platforms :ruby do
  gem 'mysql2'
  gem 'sqlite3'
end

gem 'coffee-rails', '~> 4.2.0'
gem 'sass-rails', '~> 5.0.0'

group :test do
  gem 'capybara', '~> 2.4'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'launchy'
  gem 'pry'
  gem 'rspec-activemodel-mocks'
  gem 'rspec-collection_matchers'
  gem 'rspec-its'
  gem 'rspec-rails', '~> 3.4.2'
  gem 'selenium-webdriver', '~> 2.35'
  gem 'simplecov'
  gem 'test-unit'
  gem 'timecop'
  gem 'webmock', '1.8.11'
  gem 'poltergeist', '1.5.0'
  gem 'rspec-retry'
end
