source 'https://rubygems.org'

ruby '2.1.4'
#ruby-gemset=github-viewer

gem 'rails', '~> 4.2.10'
gem 'data_kitten', :git => "git://github.com/theodi/data_kitten.git"

group :development, :test do
  gem 'sqlite3'
  gem 'yard'
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
  gem 'sass-rails',   '~> 5.0.7'
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 3.2.0'
end

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'git'
gem 'github_api'
gem 'dotenv'

group :test, :development do
  gem "coveralls"
  gem "rspec-rails", "~> 3.7"
end
