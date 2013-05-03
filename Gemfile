source 'https://rubygems.org'

ruby "2.0.0"
#ruby-gemset=github-viewer

gem 'rails', '4.0.0.rc1'

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem "foreman"
  gem "thin"
  gem "mysql2"
  gem "airbrake"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.rc1'
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

gem 'git'
gem 'github_api'
gem 'dotenv'

group :test, :development do
  gem "rspec-rails", "~> 2.0"
end