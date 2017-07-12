source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'slim-rails'
gem 'figaro'
gem 'kaminari'
gem 'capistrano-rails', group: :development
gem 'jquery-rails'
gem 'shrine'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem "faker"
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
end

gem 'bootstrap-sass'
gem 'autoprefixer-rails'


group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails_layout'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


